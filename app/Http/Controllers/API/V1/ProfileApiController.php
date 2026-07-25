<?php

namespace App\Http\Controllers\API\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\ValidationException;

class ProfileApiController extends Controller
{
    /**
     * Update user profile details.
     *
     * POST /api/v1/auth/profile
     */
    public function update(Request $request): JsonResponse
    {
        $user = $request->user();

        $rules = [
            'name' => 'sometimes|string|max:255',
            'email' => 'sometimes|string|email|max:255|unique:users,email,' . $user->id,
            'phone' => 'nullable|string|max:20',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,webp|max:2048',
            'dob' => 'nullable|date|before:today',
            'country_id' => 'nullable|integer|exists:countries,id',
        ];

        // If password is provided, require current_password and password_confirmation
        if ($request->filled('password')) {
            $rules['current_password'] = 'required|string';
            $rules['password'] = 'required|string|min:8|confirmed';
        }

        $request->validate($rules);

        // Verify current password before allowing password change
        if ($request->filled('password')) {
            if (!Hash::check($request->current_password, $user->password)) {
                throw ValidationException::withMessages([
                    'current_password' => ['The current password is incorrect.'],
                ]);
            }

            $user->password = Hash::make($request->password);
        }

        if ($request->has('name')) {
            $user->name = $request->name;
        }

        if ($request->has('email')) {
            $user->email = $request->email;
        }

        $user->save();

        // Update user detail fields (phone, image, dob, country)
        $hasDetailUpdate = $request->hasAny(['phone', 'image', 'dob', 'country_id']);

        if ($hasDetailUpdate || $request->hasFile('image')) {
            $detail = $user->detail()->firstOrCreate(['user_id' => $user->id]);

            if ($request->has('phone')) {
                $detail->mobile = $request->phone;
            }

            if ($request->hasFile('image')) {
                // Delete old image if exists
                if ($detail->image && Storage::disk('public')->exists($detail->image)) {
                    Storage::disk('public')->delete($detail->image);
                }
                $detail->image = $request->file('image')->store('users', 'public');
            }

            if ($request->has('dob')) {
                $detail->dob = $request->dob;
            }

            if ($request->has('country_id')) {
                $detail->country_id = $request->country_id;
            }

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
                    'image' => $user->detail && $user->detail->image ? Storage::url($user->detail->image) : null,
                    'dob' => $user->detail ? $user->detail->dob : null,
                    'country_id' => $user->detail ? $user->detail->country_id : null,
                    'email_verified' => !is_null($user->email_verified_at),
                    'is_sso' => !is_null($user->provider_name),
                    'provider' => $user->provider_name,
                    'created_at' => $user->created_at,
                ]
            ],
        ]);
    }
}
