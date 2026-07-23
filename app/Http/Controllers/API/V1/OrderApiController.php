<?php

namespace App\Http\Controllers\API\V1;

use App\Http\Controllers\Controller;
use App\Http\Resources\OrderResource;
use App\Http\Resources\OrderDetailResource;
use Illuminate\Http\Request;
use App\Models\Cart\Order;

class OrderApiController extends Controller
{
    /**
     * Get a list of the authenticated user's orders.
     *
     * GET /api/v1/auth/orders
     *
     * Returns: ID, reference_number, order_number, currency, amounts, status, payment_status
     */
    public function index(Request $request)
    {
        $orders = $request->user()->orders()
            ->with(['currency'])
            ->withCount('lineItems')
            ->orderBy('created_at', 'desc')
            ->paginate(15);

        return OrderResource::collection($orders);
    }

    /**
     * Get full details for a specific order.
     *
     * GET /api/v1/auth/orders/{id}
     *
     * Returns: all relations, line items with variant details, images, attributes, addresses
     */
    public function show(Request $request, $id)
    {
        $order = $request->user()->orders()
            ->with([
                'currency',
                'billingAddress.country',
                'billingAddress.province',
                'billingAddress.city',
                'billingAddress.area',
                'shippingAddress.country',
                'shippingAddress.province',
                'shippingAddress.city',
                'shippingAddress.area',
                'lineItems.productVariant.product.translation',
                'lineItems.productVariant.product.attachments',
                'lineItems.productVariant.attachments',
                'lineItems.productVariant.attributeValues.attribute',
            ])
            ->where('order_number', $id)
            ->orWhere('reference_number', $id)
            ->first();

        if (!$order) {
            return response()->json([
                'message' => 'Order not found',
            ], 404);
        }

        return new OrderDetailResource($order);
    }
}
