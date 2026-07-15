<?php

namespace App\Http\Requests\API;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rules\Password;

class ResetPasswordRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        $passwordRule = Password::min(config('password.min_length', 8));

        if (config('password.require_uppercase')) {
            $passwordRule->mixedCase();
        }
        if (config('password.require_numbers')) {
            $passwordRule->numbers();
        }
        if (config('password.require_symbols')) {
            $passwordRule->symbols();
        }

        return [
            'token' => ['required', 'string'],
            'email' => ['required', 'string', 'email'],
            'password' => ['required', 'string', 'confirmed', $passwordRule],
        ];
    }
}
