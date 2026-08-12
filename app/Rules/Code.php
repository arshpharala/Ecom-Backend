<?php

namespace App\Rules;

use Closure;
use Illuminate\Contracts\Validation\ValidationRule;

class Code implements ValidationRule
{
    /**
     * Run the validation rule.
     *
     * @param  \Closure(string, ?string=): \Illuminate\Translation\PotentiallyTranslatedString  $fail
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        if (! preg_match('/^[a-zA-Z]{2,3}([-_][a-zA-Z0-9]{2,4})?$/', $value) && ! preg_match('/^[a-zA-Z]+[a-zA-Z0-9_-]*$/', $value)) {
            $fail('The :attribute format is invalid. It must be a valid language code (e.g., en, ar, en-ae).');
        }
    }
}
