<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CurrencyResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'                => $this->id,
            'code'              => $this->code,
            'name'              => $this->name,
            'symbol'            => $this->symbol,
            'symbol_html'       => $this->symbol_html,
            'decimal'           => $this->decimal,
            'group_separator'   => $this->group_separator,
            'decimal_separator' => $this->decimal_separator,
            'currency_position' => $this->currency_position,
        ];
    }
}
