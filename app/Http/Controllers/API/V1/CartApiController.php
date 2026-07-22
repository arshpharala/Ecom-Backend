<?php

namespace App\Http\Controllers\API\V1;

use App\Http\Controllers\Controller;
use App\Models\Catalog\ProductVariant;
use App\Services\CartService;
use Illuminate\Http\Request;

class CartApiController extends Controller
{
    protected $cartService;

    public function __construct(CartService $cartService)
    {
        $this->cartService = $cartService;
    }

    public function index(Request $request)
    {
        return response()->json([
            'cart' => $this->cartService->get()
        ]);
    }

    public function addItem(Request $request)
    {
        $request->validate([
            'product_variant_id' => 'required|exists:product_variants,id',
            'quantity' => 'required|integer|min:1',
        ]);

        $variant = ProductVariant::findOrFail($request->product_variant_id);

        if (!setting('allow_negative_purchase', false) && (!$variant->stock || $variant->stock < $request->quantity)) {

            return response()->json([
                'success' => false,
                'message' => 'Insufficient stock available.'
            ], 422);
        }

        $this->cartService->add(
            $variant->id,
            $request->quantity,
            $variant->price
        );

        return response()->json([
            'success' => true,
            'message' => 'Item added to cart',
            'cart' => $this->cartService->get()
        ]);
    }

    public function updateItem(Request $request, $itemId)
    {
        $request->validate([
            'quantity' => 'required|integer|min:1',
        ]);

        $variant = ProductVariant::findOrFail($itemId);


        if (!setting('allow_negative_purchase', false) && (!$variant->stock || $variant->stock < $request->quantity)) {

            return response()->json([
                'success' => false,
                'message' => 'Insufficient stock available.'
            ], 422);
        }

        $this->cartService->update($itemId, $request->quantity);

        return response()->json([
            'success' => true,
            'message' => 'Cart updated',
            'cart' => $this->cartService->get()
        ]);
    }

    public function removeItem(Request $request, $itemId)
    {
        $this->cartService->remove($itemId);

        return response()->json([
            'message' => 'Item removed from cart',
            'cart' => $this->cartService->get()
        ]);
    }

    public function clearCart(Request $request)
    {
        $this->cartService->clear();

        return response()->json([
            'message' => 'Cart cleared',
            'cart' => $this->cartService->get()
        ]);
    }
}
