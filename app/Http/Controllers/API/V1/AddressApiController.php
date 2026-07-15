<?php

namespace App\Http\Controllers\API\V1;

use App\Http\Controllers\Controller;
use App\Models\Address;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class AddressApiController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $addresses = $request->user()->addresses()
            ->with(['country', 'province', 'city', 'area'])
            ->get();

        return response()->json([
            'success' => true,
            'data' => $addresses
        ]);
    }

    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'phone' => 'required|string|max:20',
            'country_id' => 'required|exists:countries,id',
            'province_id' => 'required|exists:provinces,id',
            'city_id' => 'required|exists:cities,id',
            'area_id' => 'nullable|exists:areas,id',
            'address' => 'required|string',
            'landmark' => 'nullable|string',
            'map_latitude' => 'nullable|numeric',
            'map_longitude' => 'nullable|numeric',
            'map_url' => 'nullable|url',
        ]);

        $address = $request->user()->addresses()->create($validated);

        return response()->json([
            'success' => true,
            'message' => 'Address added successfully.',
            'data' => $address->load(['country', 'province', 'city', 'area'])
        ], 201);
    }

    public function update(Request $request, $id): JsonResponse
    {
        $address = $request->user()->addresses()->findOrFail($id);

        $validated = $request->validate([
            'name' => 'sometimes|required|string|max:255',
            'phone' => 'sometimes|required|string|max:20',
            'country_id' => 'sometimes|required|exists:countries,id',
            'province_id' => 'sometimes|required|exists:provinces,id',
            'city_id' => 'sometimes|required|exists:cities,id',
            'area_id' => 'nullable|exists:areas,id',
            'address' => 'sometimes|required|string',
            'landmark' => 'nullable|string',
            'map_latitude' => 'nullable|numeric',
            'map_longitude' => 'nullable|numeric',
            'map_url' => 'nullable|url',
        ]);

        $address->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'Address updated successfully.',
            'data' => $address->load(['country', 'province', 'city', 'area'])
        ]);
    }

    public function destroy(Request $request, $id): JsonResponse
    {
        $address = $request->user()->addresses()->findOrFail($id);
        $address->delete();

        return response()->json([
            'success' => true,
            'message' => 'Address deleted successfully.'
        ]);
    }
}
