<?php

namespace App\Http\Controllers\API\V1;

use App\Http\Controllers\Controller;
use App\Models\Catalog\AttributeValue;
use App\Models\Catalog\Product;
use App\Http\Requests\StoreWishlistRequest;
use App\Models\Wishlist;
use App\Repositories\ProductVariantRepository;
use App\Services\CartService;
use App\Services\WishlistService;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class ProductApiController extends Controller
{
    protected $repository;
    protected $cart;

    public function __construct(ProductVariantRepository $repository, CartService $cart)
    {
        $this->repository = $repository;
        $this->cart = $cart;
    }

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $limit = $request->limit;

        if ($request->limit > 12 || $request->limit < 1) {
            $limit = 12;
        }

        $products = $this->repository->getFiltered($limit);

        return response()->json([
            'success' => true,
            'data' => $products
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $productVariant = $this->repository->getProductVariant($id);
        $product        = $this->repository->getProductWithAttributes($productVariant->product_id);

        $attributes     = $this->repository->extractAttributesFromVariants($product);
        $selected       = $this->repository->getSelectedAttributes($productVariant);
        $allVariants    = $this->formatAllVariants($product);

        $data['productVariant'] = $productVariant;
        $data['product']        = $product;
        $data['attributes']     = $attributes;
        $data['selected']       = $selected;
        $data['allVariants']    = $allVariants;

        if (empty($product->metaForLocale()->meta_title)) {
            $data['meta'] = (object)[
                'meta_title' => $productVariant->name,
                'meta_description' => Str::limit($productVariant->description, 160)
            ];
        } else {
            $data['meta'] = $product ? $product->metaForLocale() : null;
        }

        return response()->json([
            'success' => true,
            'data' => $data
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }


    /**
     * ✅ All variants formatter
     * If product has Size => return variants sorted like:
     * - In-stock first
     * - Size order (Small -> Medium -> Large -> XL -> ...)
     */
    public function formatAllVariants($product)
    {
        $allVariants = [];

        foreach ($product->variants as $variant) {
            $combo = [];

            foreach ($variant->attributeValues as $val) {
                $slug = Str::slug($val->attribute->name);
                $combo[$slug] = $val->value;
            }

            $allVariants[] = [
                'id' => $variant->id,
                'slug' => $variant->product->slug,
                'combination' => $combo,
                'price' => $variant->price,
                'stock' => $variant->stock,
                'image' => $variant->attachments->first()?->file_path,
                'cart_item' => $this->cart->getItem($variant->id)
            ];
        }

        // ✅ If Size exists, apply sort rules
        $hasSize = collect($allVariants)->contains(function ($v) {
            return isset($v['combination']['size']);
        });

        if ($hasSize) {
            usort($allVariants, function ($a, $b) {

                $stockA = (int) ($a['stock'] ?? 0);
                $stockB = (int) ($b['stock'] ?? 0);

                $inStockA = $stockA > 0 ? 1 : 0;
                $inStockB = $stockB > 0 ? 1 : 0;

                // 1) In-stock always first
                if ($inStockA !== $inStockB) {
                    return $inStockB <=> $inStockA;
                }

                // 2) Sort by size weight
                $sizeA = $a['combination']['size'] ?? null;
                $sizeB = $b['combination']['size'] ?? null;

                $weightA = AttributeValue::getSizeSortWeight($sizeA);
                $weightB = AttributeValue::getSizeSortWeight($sizeB);

                if ($weightA === $weightB) {
                    return strcmp((string) $sizeA, (string) $sizeB);
                }

                return $weightA <=> $weightB;
            });
        }

        return $allVariants;
    }

    /**
     * Wishlist the product
     */
    public function wishlist(StoreWishlistRequest $request, WishlistService $wishlistService)
    {
        $userId = auth()->id();
        $variantId = $request->validated()['product_variant_id'];

        $action = $request->input('action')
            ?? $request->input('status')
            ?? $request->input('enable')
            ?? ($request->has('toggle') ? ((bool)$request->input('toggle') ? 'toggle' : 'enable') : 'toggle');

        $result = $wishlistService->updateWishlist($userId, $variantId, $action);

        return response()->json($result);
    }
}
