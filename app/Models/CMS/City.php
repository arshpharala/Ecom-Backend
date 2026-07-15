<?php

namespace App\Models\CMS;

use Illuminate\Database\Eloquent\Model;

class City extends Model
{
    public function areas()
    {
        return $this->hasMany(Area::class);
    }
}
