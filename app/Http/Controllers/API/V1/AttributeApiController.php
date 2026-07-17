<?php

namespace App\Http\Controllers\API\V1;

use App\Http\Controllers\Controller;
use App\Models\Catalog\Attribute;
use Illuminate\Http\Request;

class AttributeApiController extends Controller
{
    /**
     * Display a listing of the attributes and their values.
     */
    public function index()
    {
        $attributes = Attribute::with('values')->get();

        $data = $attributes->map(function ($attribute) {
            return [
                'id' => $attribute->id,
                'name' => $attribute->name,
                // 'position' => 0, // Defaulting to 0 since position isn't in the model
                'values' => $attribute->values->map(function ($value) {
                    return [
                        'id' => $value->id,
                        'name' => $value->value, // Value string is used as the name
                    ];
                })->values()->all()
            ];
        });

        return response()->json([
            'success' => true,
            'data' => $data
        ]);
    }
}
