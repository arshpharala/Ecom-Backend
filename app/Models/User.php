<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use App\Models\Address;
use App\Models\Cart\BillingAddress;
use App\Models\Cart\Order;
use App\Models\Cart\UserCard;
use App\Models\UserDetail;
use App\Models\Wishlist;
use App\Notifications\CustomResetPassword;
use App\Notifications\CustomVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable implements MustVerifyEmail
{
    /** @use HasFactory<UserFactory> */
    use HasApiTokens, HasFactory, Notifiable;

    protected $guard = 'web';

    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'is_active',
        'is_guest',
        'last_login_at',
        'password_changed_at',
        'stripe_id',
        'provider_name',
        'provider_id',
        'email_verified_at'
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'last_login_at' => 'datetime',
            'password' => 'hashed',
            'is_active' => 'boolean',
            'is_guest' => 'boolean'
        ];
    }


    public function scopeGuest($query)
    {
        return $query->where('is_guest', 1);
    }

    public function scopeActive($query)
    {
        return $query->where('users.is_active', 1);
    }

    public function detail()
    {
        return $this->hasOne(UserDetail::class);
    }

    public function orders()
    {
        return $this->hasMany(Order::class);
    }

    public function addresses()
    {
        return $this->hasMany(Address::class);
    }

    public function billingAddresses()
    {
        return $this->hasMany(BillingAddress::class);
    }

    public function cards()
    {
        return $this->hasMany(UserCard::class);
    }

    public function wishlist()
    {
        return $this->hasMany(Wishlist::class);
    }

    public function returnRequests()
    {
        return $this->hasMany(\App\Models\Sales\ReturnRequest::class);
    }

    public function sendPasswordResetNotification($token)
    {
        $frontendUrl = config('app.frontend_url', 'http://localhost:3000');
        $url = "{$frontendUrl}/reset-password?token={$token}&email=" . urlencode($this->email);
        $this->notify(new CustomResetPassword($url));
    }

    public function sendEmailVerificationNotification()
    {
        $this->notify(new CustomVerifyEmail);
    }
}
