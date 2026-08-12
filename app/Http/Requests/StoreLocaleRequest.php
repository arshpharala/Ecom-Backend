<?php

namespace App\Http\Requests;

use App\Rules\Code;
use App\Enums\TextDirection;
use Illuminate\Validation\Rules\Enum;
use Illuminate\Foundation\Http\FormRequest;

class StoreLocaleRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Prepare the data for validation.
     */
    protected function prepareForValidation(): void
    {
        if ($this->has('code')) {
            $this->merge([
                'code' => strtolower(trim((string) $this->code)),
            ]);
        }

        if ($this->has('direction')) {
            $this->merge([
                'direction' => strtolower(trim((string) $this->direction)),
            ]);
        }
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'code'       => ['required', 'unique:locales,code', new Code],
            'name'       => 'required|string|max:100',
            'direction'  => ['required', new Enum(TextDirection::class)],
            'logo'       => 'nullable|image|max:2048',
        ];
    }
}
