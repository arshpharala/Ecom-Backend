<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * Full order detail resource — includes all relations,
 * line items with variant/product details, images, and addresses.
 */
class OrderDetailResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'                 => $this->id,
            'reference_number'   => $this->reference_number,
            'order_number'       => $this->order_number,
            'email'              => $this->email,
            'status'             => $this->status,
            'payment_status'     => $this->payment_status,
            'payment_method'     => $this->payment_method,
            'external_reference' => $this->external_reference,

            // Amounts
            'sub_total'          => $this->sub_total,
            'tax'                => $this->tax,
            'total'              => $this->total,

            // Currency
            'currency'           => new CurrencyResource($this->whenLoaded('currency')),

            // Addresses
            'billing_address'    => new AddressResource($this->whenLoaded('billingAddress')),
            'shipping_address'   => new AddressResource($this->whenLoaded('shippingAddress')),

            // Tracking
            'tracking_number'    => $this->tracking_number,
            'tracking_link'      => $this->tracking_link,
            'tracking_provider'  => $this->tracking_provider,
            'tracking_status'    => $this->tracking_status,

            // Line items with variants, images, attributes
            'line_items'         => OrderLineItemResource::collection($this->whenLoaded('lineItems')),

            // Timestamps
            'delivered_at'       => $this->delivered_at?->toIso8601String(),
            'created_at'        => $this->created_at?->toIso8601String(),
            'updated_at'        => $this->updated_at?->toIso8601String(),
        ];
    }
}
