<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AddressResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'        => $this->id,
            'name'      => $this->name,
            'phone'     => $this->phone,
            'address'   => $this->address,
            'landmark'  => $this->landmark,
            'country'   => $this->whenLoaded('country', fn() => [
                'id'   => $this->country->id,
                'name' => $this->country->name,
            ]),
            'province'  => $this->whenLoaded('province', fn() => [
                'id'   => $this->province->id,
                'name' => $this->province->name,
            ]),
            'city'      => $this->whenLoaded('city', fn() => [
                'id'   => $this->city->id,
                'name' => $this->city->name,
            ]),
            'area'      => $this->whenLoaded('area', fn() => [
                'id'   => $this->area->id,
                'name' => $this->area->name,
            ]),
        ];
    }
}
