<?php

namespace App\Http\Controllers\API\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Models\Cart\Order;

class OrderApiController extends Controller
{
    /**
     * Get a list of the authenticated user's orders.
     *
     * GET /api/v1/orders
     */
    public function index(Request $request): JsonResponse
    {
        $orders = $request->user()->orders()
            ->with(['currency'])
            ->orderBy('created_at', 'desc')
            ->paginate(15);

        return response()->json([
            'success' => true,
            'data' => $orders
        ]);
    }

    /**
     * Get details for a specific order.
     *
     * GET /api/v1/orders/{id}
     */
    public function show(Request $request, $id): JsonResponse
    {
        $order = $request->user()->orders()
            ->with([
                'lineItems.productVariant.product',
                'lineItems.productVariant.attachments',
                'shippingAddress', 
                'billingAddress', 
                'currency'
            ])
            ->findOrFail($id);

        return response()->json([
            'success' => true,
            'data' => $order
        ]);
    }
}
