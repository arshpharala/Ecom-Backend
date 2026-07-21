<?php

namespace App\Services;

use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Cache;
use App\Models\Cart\Coupon;
use App\Models\Cart\Cart;
use App\Services\CouponService;

class CartService
{
    protected function getCartModel()
    {
        $userId = auth('sanctum')->id();
        $sessionId = request()->header('X-Cart-Session-Id');
        
        if (!$sessionId && !$userId) {
            $sessionId = request()->ip(); // Fallback if neither is provided
        }

        $userCart = null;
        $guestCart = null;

        if ($userId) {
            $userCart = Cart::where('user_id', $userId)->first();
        }

        if ($sessionId) {
            $guestCart = Cart::where('session_id', $sessionId)->whereNull('user_id')->first();
        }

        // Scenario 1: User just logged in, has a guest cart, and NO existing user cart
        if ($userId && $guestCart && !$userCart) {
            $guestCart->update(['user_id' => $userId]);
            return $guestCart;
        }

        // Scenario 2: User logged in, has a guest cart, AND has an existing user cart (Merge carts!)
        if ($userId && $guestCart && $userCart) {
            foreach ($guestCart->items as $guestItem) {
                $existingItem = $userCart->items()->where('product_variant_id', $guestItem->product_variant_id)->first();
                if ($existingItem) {
                    $existingItem->quantity += $guestItem->quantity;
                    $existingItem->save();
                } else {
                    $guestItem->update(['cart_id' => $userCart->id]);
                }
            }
            $guestCart->delete(); // Delete the now-empty guest cart
            return $userCart;
        }

        // Scenario 3: Logged in user with existing cart, no guest cart
        if ($userCart) {
            return $userCart;
        }

        // Scenario 4: Guest user with existing guest cart
        if (!$userId && $guestCart) {
            return $guestCart;
        }

        // Scenario 5: Brand new cart
        return Cart::create([
            'user_id' => $userId,
            'session_id' => $sessionId,
        ]);
    }

    public function get(): Collection
    {
        $items         = $this->getItems();
        $subTotal      = $this->getSubTotal();
        $discount      = $this->getDiscount();
        $tax           = $this->getTax();
        $total         = $this->getTotal();

        return collect([
            'items'     => $items,
            'subTotal'  => $subTotal,
            'discount'  => $discount,
            'tax'       => $tax,
            'total'     => $total,
            'currency'  => active_currency(),
            'subTotal_with_currency'  => price_format(active_currency(), $subTotal),
            'discount_with_currency'  => price_format(active_currency(), $discount),
            'tax_with_currency'       => price_format(active_currency(), $tax),
            'total_with_currency'     => price_format(active_currency(), $total),
            'count'     => $this->getItemCount(),
            'coupon'    => $this->getCoupon(),
        ]);
    }

    function getTax(): float
    {
        $subTotal      = $this->getSubTotal();
        $discount      = $this->getDiscount();
        $discountedSub = max($subTotal - $discount, 0);
        $tax           = $this->getTaxOnAmount($discountedSub);

        return (float) $tax;
    }

    public function getSubTotal(): float
    {
        return array_sum(array_column($this->getItems(), 'subtotal'));
    }

    public function getDiscount(): float
    {
        $data = $this->getCoupon();
        return $data['discount'] ?? 0;
    }

    public function getTaxOnAmount(float $amount): float
    {
        $taxRate = setting('tax_rate', 5);
        return round($amount * ($taxRate / 100), 2);
    }

    public function getTotal(): float
    {
        $subTotal = $this->getSubTotal();
        $discounted = max($subTotal - $this->getDiscount($subTotal), 0);
        return $discounted + $this->getTaxOnAmount($discounted);
    }

    public function getItems(): array
    {
        $cart = $this->getCartModel();
        
        $cart->load([
            'items.variant.product.translation',
            'items.variant.attributeValues.attribute',
            'items.variant.attachments'
        ]);

        $items = [];
        
        foreach($cart->items as $dbItem) {
            $variant = $dbItem->variant;
            $productName = $variant->product->translation->name ?? $variant->product->slug ?? 'Unknown Product';
            $image = $variant->getThumbnail();
            
            $attributes = [];
            if ($variant->attributeValues) {
                foreach ($variant->attributeValues as $attrVal) {
                    $attributes[] = [
                        'name' => $attrVal->attribute->name ?? '',
                        'value' => $attrVal->value ?? ''
                    ];
                }
            }

            $items[$dbItem->product_variant_id] = [
                'qty' => $dbItem->quantity,
                'price' => $dbItem->price,
                'subtotal' => $dbItem->quantity * $dbItem->price,
                'name' => $productName,
                'image' => $image,
                'attributes' => $attributes,
                'sku' => $variant->sku,
                'stock' => $variant->stock,
                'options' => [],
            ];
        }
        
        return $items;
    }

    public function getItem(string $variantId): ?array
    {
        return $this->getItems()[$variantId] ?? null;
    }

    public function add(string $variantId, int $qty = 1, float $price = null, array $options = []): void
    {
        $cart = $this->getCartModel();
        $item = $cart->items()->where('product_variant_id', $variantId)->first();
        
        if ($item) {
            $item->quantity += $qty;
            $item->save();
        } else {
            $cart->items()->create([
                'product_variant_id' => $variantId,
                'quantity' => $qty,
                'price' => $price,
            ]);
        }
    }

    public function update(string $variantId, int $qty): void
    {
        $cart = $this->getCartModel();
        $item = $cart->items()->where('product_variant_id', $variantId)->first();
        
        if ($item) {
            $item->quantity = $qty;
            $item->save();
        }
    }

    public function remove(string $variantId): void
    {
        $cart = $this->getCartModel();
        $cart->items()->where('product_variant_id', $variantId)->delete();
    }

    public function clear(): void
    {
        $cart = $this->getCartModel();
        $cart->items()->delete();
        $this->removeCoupon();
    }

    public function getItemCount(): int
    {
        return array_sum(array_column($this->getItems(), 'qty'));
    }

    public function applyCoupon(string $code, $user = null): array
    {
        $items = $this->getItems();
        $variantIds = array_keys($items);
        $cartTotal = $this->getSubTotal();

        $result = app(CouponService::class)->applyCoupon($code, $cartTotal, $user, $variantIds);

        if ($result['success']) {
            $cart = $this->getCartModel();
            Cache::put('cart_coupon_'.$cart->id, [
                'code'      => $result['coupon']->code,
                'id'        => $result['coupon']->id,
                'discount'  => $result['discount'],
                'type'      => $result['coupon']->type,
                'value'     => $result['coupon']->value,
            ], now()->addDays(7));
        }

        return $result;
    }

    public function removeCoupon(): void
    {
        $cart = $this->getCartModel();
        Cache::forget('cart_coupon_'.$cart->id);
    }

    public function getCoupon(): ?array
    {
        $cart = $this->getCartModel();
        return Cache::get('cart_coupon_'.$cart->id);
    }

    public function hasCoupon(): bool
    {
        $cart = $this->getCartModel();
        return Cache::has('cart_coupon_'.$cart->id);
    }

    public function refresh(): ?string
    {
        $items = $this->getItems();
        $subTotal = $this->getSubTotal();

        if ($this->hasCoupon()) {
            $couponData = $this->getCoupon();
            $coupon = Coupon::find($couponData['id']);

            if (!$coupon) {
                $this->removeCoupon();
                return 'Coupon was removed: no longer valid.';
            }

            if (empty($items)) {
                $this->removeCoupon();
                return 'Coupon was removed: your cart is empty.';
            }

            if ($subTotal < ($coupon->min_cart_amount ?? 0)) {
                $this->removeCoupon();
                return 'Coupon was removed: subtotal is below the required minimum.';
            }
        }

        return null; // no issues
    }
}
