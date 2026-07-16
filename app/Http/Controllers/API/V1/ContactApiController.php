<?php

namespace App\Http\Controllers\API\V1;

use App\Http\Controllers\Controller;
use App\Models\ContactSubmission;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class ContactApiController extends Controller
{
    /**
     * Store a newly created contact submission in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'phone' => 'nullable|string|max:20',
            'subject' => 'nullable|string|max:255',
            'message' => 'required|string',
        ]);

        $contact = new ContactSubmission($validated);
        $contact->ip_address = $request->ip();
        
        if (auth('sanctum')->check()) {
            $contact->user_id = auth('sanctum')->id();
        }

        $contact->save();

        return response()->json([
            'success' => true,
            'message' => 'Contact submission received successfully.',
            'data' => $contact
        ], 201);
    }
}
