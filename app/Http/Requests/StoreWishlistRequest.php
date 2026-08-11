<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreWishlistRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return auth()->check();
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'product_variant_id' => 'required|string|exists:product_variants,id',
            'action'             => 'sometimes|nullable',
            'status'             => 'sometimes|nullable',
            'enable'             => 'sometimes|nullable',
            'toggle'             => 'sometimes|nullable',
        ];
    }

    public function messages(): array
    {
        return [
            'product_variant_id.required' => 'Select a specific product variant.',
            'product_variant_id.exists'   => 'The selected product variant does not exist.',
        ];
    }
}
