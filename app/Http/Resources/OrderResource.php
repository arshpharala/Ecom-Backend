<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * Lightweight order resource for the orders list API.
 * Returns: ID, reference, number, currency, amounts, status, payment status.
 */
class OrderResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'               => $this->id,
            'reference_number' => $this->reference_number,
            'order_number'     => $this->order_number,
            'status'           => $this->status,
            'payment_status'   => $this->payment_status,
            'payment_method'   => $this->payment_method,

            // Amounts
            'sub_total'        => $this->sub_total,
            'tax'              => $this->tax,
            'total'            => $this->total,

            // Currency
            'currency'         => new CurrencyResource($this->whenLoaded('currency')),

            // Items count for quick display
            'items_count'      => $this->whenCounted('lineItems'),

            'created_at'       => $this->created_at?->toIso8601String(),
        ];
    }
}
