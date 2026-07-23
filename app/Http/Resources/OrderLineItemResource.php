<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class OrderLineItemResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        $variant = $this->whenLoaded('productVariant');

        return [
            'id'         => $this->id,
            'quantity'   => $this->quantity,
            'price'      => $this->price,
            'subtotal'   => $this->subtotal,
            'options'    => $this->options,

            // Variant details
            'variant'    => $this->when($this->relationLoaded('productVariant'), function () {
                $variant = $this->productVariant;

                return [
                    'id'    => $variant->id,
                    'sku'   => $variant->sku,
                    'price' => $variant->price,
                    'stock' => $variant->stock,

                    // Attribute values (e.g. Size: M, Color: Black)
                    'attributes' => $this->when($variant->relationLoaded('attributeValues'), function () use ($variant) {
                        return $variant->attributeValues->map(fn($av) => [
                            'id'        => $av->id,
                            'value'     => $av->value,
                            'attribute' => $av->relationLoaded('attribute') ? [
                                'id'   => $av->attribute->id,
                                'name' => $av->attribute->name ?? $av->attribute->slug,
                            ] : null,
                        ]);
                    }),

                    // Variant images
                    'images' => $this->when($variant->relationLoaded('attachments'), function () use ($variant) {
                        return $variant->attachments->map(fn($att) => [
                            'id'        => $att->id,
                            'url'       => $att->url,
                            'file_name' => $att->file_name,
                        ]);
                    }),

                    // Product details
                    'product' => $this->when($variant->relationLoaded('product'), function () use ($variant) {
                        $product = $variant->product;

                        return [
                            'id'          => $product->id,
                            'slug'        => $product->slug,
                            'name'        => $product->relationLoaded('translation') ? $product->translation?->name : null,
                            'description' => $product->relationLoaded('translation') ? $product->translation?->description : null,

                            // Product-level images
                            'images' => $this->when($product->relationLoaded('attachments'), function () use ($product) {
                                return $product->attachments->map(fn($att) => [
                                    'id'        => $att->id,
                                    'url'       => $att->url,
                                    'file_name' => $att->file_name,
                                ]);
                            }),
                        ];
                    }),
                ];
            }),
        ];
    }
}
