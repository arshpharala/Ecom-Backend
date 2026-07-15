<?php

namespace App\Http\Controllers\API\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Hash;

class ProfileApiController extends Controller
{
    /**
     * Update user profile details.
     *
     * PUT /api/v1/auth/profile
     */
    public function update(Request $request): JsonResponse
    {
        $user = $request->user();

        $request->validate([
            'name' => 'sometimes|string|max:255',
            'email' => 'sometimes|string|email|max:255|unique:users,email,' . $user->id,
            'password' => 'nullable|string|min:8',
            'phone' => 'nullable|string|max:20',
        ]);

        if ($request->has('name')) {
            $user->name = $request->name;
        }

        if ($request->has('email')) {
            $user->email = $request->email;
        }

        if ($request->filled('password')) {
            $user->password = Hash::make($request->password);
        }

        $user->save();

        if ($request->has('phone')) {
            $detail = $user->detail()->firstOrCreate(['user_id' => $user->id]);
            $detail->mobile = $request->phone;
            $detail->save();
        }

        $user->load('detail');

        return response()->json([
            'success' => true,
            'message' => 'Profile updated successfully.',
            'data' => [
                'user' => [
                    'id' => $user->id,
                    'name' => $user->name,
                    'email' => $user->email,
                    'phone' => $user->detail ? $user->detail->mobile : null,
                    'email_verified' => !is_null($user->email_verified_at),
                    'is_sso' => !is_null($user->provider_name),
                    'provider' => $user->provider_name,
                    'created_at' => $user->created_at,
                ]
            ],
        ]);
    }
}
