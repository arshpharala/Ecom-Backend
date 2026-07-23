<?php

namespace App\Http\Controllers\API\V1;

use App\Http\Controllers\Controller;
use App\Models\Sales\Subscriber;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class SubscriberApiController extends Controller
{
    /**
     * Subscribe to newsletter.
     *
     * POST /api/v1/subscribe
     */
    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'email' => 'required|email|max:255',
        ]);

        // Check if already subscribed (including soft-deleted — re-activate if trashed)
        $existing = Subscriber::withTrashed()
            ->where('email', $request->email)
            ->first();

        if ($existing) {
            if ($existing->trashed() || $existing->unsubscribed_at) {
                // Re-subscribe: restore and clear unsubscribe date
                $existing->restore();
                $existing->update([
                    'unsubscribed_at' => null,
                    'subscribed_at'   => now(),
                    'ip_address'      => $request->ip(),
                    'user_agent'      => $request->userAgent(),
                ]);

                return response()->json([
                    'message' => 'You have been re-subscribed successfully.',
                ]);
            }

            return response()->json([
                'message' => 'This email is already subscribed.',
            ], 409);
        }

        Subscriber::create([
            'email'         => $request->email,
            'user_id'       => auth('sanctum')->id(),
            'ip_address'    => $request->ip(),
            'user_agent'    => $request->userAgent(),
            'subscribed_at' => now(),
        ]);

        return response()->json([
            'message' => 'Subscribed successfully.',
        ], 201);
    }
}
