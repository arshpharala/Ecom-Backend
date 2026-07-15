<?php

namespace App\Http\Controllers\API\V1\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class EmailVerificationController extends Controller
{
    /**
     * Verify the user's email address.
     *
     * POST /api/v1/auth/email/verify
     * Body: { id, hash, expires, signature }
     *
     * The React frontend receives a signed URL from the verification email,
     * extracts the params, and posts them here.
     */
    public function verify(Request $request): JsonResponse
    {
        $request->validate([
            'id' => ['required', 'integer'],
            'hash' => ['required', 'string'],
            'expires' => ['required', 'integer'],
            'signature' => ['required', 'string'],
        ]);

        $user = User::findOrFail($request->id);

        // Check if the hash matches
        if (!hash_equals(sha1($user->getEmailForVerification()), $request->hash)) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid verification link.',
            ], 422);
        }

        // Check if the link has expired
        if (now()->timestamp > $request->expires) {
            return response()->json([
                'success' => false,
                'message' => 'Verification link has expired. Please request a new one.',
            ], 422);
        }

        // Check if already verified
        if ($user->hasVerifiedEmail()) {
            return response()->json([
                'success' => true,
                'message' => 'Email is already verified.',
            ]);
        }

        $user->markEmailAsVerified();

        return response()->json([
            'success' => true,
            'message' => 'Email verified successfully.',
        ]);
    }

    /**
     * Resend the email verification notification.
     *
     * POST /api/v1/auth/email/resend
     * Header: Authorization: Bearer {token}
     */
    public function resend(Request $request): JsonResponse
    {
        $user = $request->user();

        if ($user->hasVerifiedEmail()) {
            return response()->json([
                'success' => true,
                'message' => 'Email is already verified.',
            ]);
        }

        $user->sendEmailVerificationNotification();

        return response()->json([
            'success' => true,
            'message' => 'Verification email has been resent.',
        ]);
    }
}
