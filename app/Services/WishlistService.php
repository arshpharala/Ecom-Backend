<?php

namespace App\Services;

use App\Models\Wishlist;
use App\Models\Catalog\ProductVariant;
use Illuminate\Validation\ValidationException;

class WishlistService
{
    /**
     * Add, remove, or toggle a product variant in the user's wishlist.
     *
     * @param string $userId
     * @param string $variantId
     * @param mixed $action Can be 'enable'/'add', 'disable'/'remove', 'toggle', or boolean/integer
     * @return array
     */
    public function updateWishlist(string $userId, string $variantId, mixed $action = 'toggle'): array
    {
        // Verify variant exists
        $variantExists = ProductVariant::where('id', $variantId)->exists();
        if (!$variantExists) {
            throw ValidationException::withMessages([
                'product_variant_id' => ['The specified product variant does not exist.']
            ]);
        }

        // Resolve action mode: 'enable', 'disable', or 'toggle'
        $mode = $this->resolveMode($action);

        $existing = Wishlist::query()
            ->where('user_id', $userId)
            ->where('product_variant_id', $variantId)
            ->first();

        $isWishlisted = false;
        $message = '';

        if ($mode === 'toggle') {
            if ($existing) {
                $existing->delete();
                $isWishlisted = false;
                $message = 'Removed from wishlist';
            } else {
                Wishlist::create([
                    'user_id' => $userId,
                    'product_variant_id' => $variantId,
                ]);
                $isWishlisted = true;
                $message = 'Added to wishlist';
            }
        } elseif ($mode === 'enable') {
            if ($existing) {
                $isWishlisted = true;
                $message = 'Already in wishlist';
            } else {
                Wishlist::create([
                    'user_id' => $userId,
                    'product_variant_id' => $variantId,
                ]);
                $isWishlisted = true;
                $message = 'Added to wishlist';
            }
        } elseif ($mode === 'disable') {
            if ($existing) {
                $existing->delete();
                $isWishlisted = false;
                $message = 'Removed from wishlist';
            } else {
                $isWishlisted = false;
                $message = 'Not in wishlist';
            }
        }

        // Refresh user wishlist cache
        Wishlist::cacheWishlists($userId);

        $count = Wishlist::forUser($userId)->count();

        return [
            'success' => true,
            'message' => $message,
            'data' => [
                'product_variant_id' => $variantId,
                'is_wishlisted' => $isWishlisted,
                'count' => $count,
            ],
            // Backward compatibility for existing callers expecting wishlist.count
            'wishlist' => [
                'count' => $count,
            ]
        ];
    }

    /**
     * Explicitly remove a variant from wishlist.
     */
    public function removeWishlist(string $userId, string $variantId): array
    {
        return $this->updateWishlist($userId, $variantId, 'disable');
    }

    /**
     * Resolve action parameter into 'enable', 'disable', or 'toggle'.
     */
    protected function resolveMode(mixed $action): string
    {
        if (is_bool($action)) {
            return $action ? 'enable' : 'disable';
        }

        if (is_numeric($action)) {
            return ((int)$action === 1) ? 'enable' : 'disable';
        }

        if (is_string($action)) {
            $normalized = strtolower(trim($action));
            if (in_array($normalized, ['enable', 'add', 'true', '1'])) {
                return 'enable';
            }
            if (in_array($normalized, ['disable', 'remove', 'false', '0'])) {
                return 'disable';
            }
            if ($normalized === 'toggle') {
                return 'toggle';
            }
        }

        return 'toggle';
    }
}
