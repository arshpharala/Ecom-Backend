<?php

namespace App\Http\Controllers\API\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreWishlistRequest;
use App\Models\Wishlist;
use App\Repositories\ProductVariantRepository;
use App\Services\WishlistService;
use Illuminate\Http\Request;

class WishlistApiController extends Controller
{
    protected WishlistService $wishlistService;

    public function __construct(WishlistService $wishlistService)
    {
        $this->wishlistService = $wishlistService;
    }

    /**
     * Get list of wishlisted products/variants for the logged-in user.
     * GET /api/v1/wishlist
     */
    public function index(Request $request, ProductVariantRepository $repository)
    {
        $request->merge(['is_wishlisted' => true]);
        $perPage = (int) $request->get('per_page', 12);

        $wishlistItems = $repository->getFiltered($perPage);

        return response()->json([
            'success' => true,
            'data'    => $wishlistItems,
            'count'   => Wishlist::forUser(auth()->id())->count(),
        ]);
    }

    /**
     * Store/Update wishlist item (enable, disable, or toggle).
     * POST /api/v1/wishlist
     */
    public function store(StoreWishlistRequest $request)
    {
        $userId = auth()->id();
        $variantId = $request->validated()['product_variant_id'];

        $action = $request->input('action')
            ?? $request->input('status')
            ?? $request->input('enable')
            ?? ($request->has('toggle') ? ((bool)$request->input('toggle') ? 'toggle' : 'enable') : 'toggle');

        $result = $this->wishlistService->updateWishlist($userId, $variantId, $action);

        return response()->json($result);
    }

    /**
     * Remove a specific variant from wishlist.
     * DELETE /api/v1/wishlist/{variantId}
     */
    public function destroy($variantId)
    {
        $userId = auth()->id();
        $result = $this->wishlistService->removeWishlist($userId, $variantId);

        return response()->json($result);
    }
}
