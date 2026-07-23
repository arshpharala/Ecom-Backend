<?php

namespace App\Http\Controllers\API\V1;

use App\Http\Controllers\Controller;
use App\Models\Address;
use App\Models\Cart\CouponUsage;
use App\Models\Cart\Order;
use App\Models\Cart\OrderLineItem;
use App\Models\User;
use App\Services\CartService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class CheckoutApiController extends Controller
{
    protected $cartService;

    public function __construct(CartService $cartService)
    {
        $this->cartService = $cartService;
    }

    public function applyCoupon(Request $request)
    {
        $request->validate([
            'code' => 'required|string'
        ]);

        $user = auth('sanctum')->user();
        $result = $this->cartService->applyCoupon($request->code, $user);

        if ($result['success']) {
            return response()->json([
                'message' => 'Coupon applied successfully',
                'cart' => $this->cartService->get()
            ]);
        }

        return response()->json(['message' => $result['message'] ?? 'Invalid coupon'], 400);
    }

    public function removeCoupon(Request $request)
    {
        $this->cartService->removeCoupon();

        return response()->json([
            'message' => 'Coupon removed successfully',
            'cart' => $this->cartService->get()
        ]);
    }

    public function checkout(Request $request)
    {
        $cartData = $this->cartService->get();

        if ($cartData['count'] === 0) {
            return response()->json(['message' => 'Cart is empty'], 400);
        }

        $user = auth('sanctum')->user();
        
        $rules = [
            'payment_method' => 'required|string',
        ];

        if (!$user) {
            $rules = array_merge($rules, [
                'name' => 'required|string|max:255',
                'email' => 'required|email|max:255',
                'phone' => 'required|string|max:20',
                'address' => 'required|string',
                'city_id' => 'required|integer',
                'province_id' => 'required|integer',
                'country_id' => 'required|integer',
            ]);
        } else {
            $rules['billing_address_id'] = 'required|exists:addresses,id';
            $rules['shipping_address_id'] = 'required|exists:addresses,id';
        }

        $validated = $request->validate($rules);

        DB::beginTransaction();
        try {
            if (!$user) {
                // Check if email already exists
                $existingUser = User::where('email', $validated['email'])->first();
                if ($existingUser && !$existingUser->is_guest) {
                    return response()->json(['message' => 'Email already registered. Please log in.'], 400);
                }

                if ($existingUser && $existingUser->is_guest) {
                    $user = $existingUser;
                } else {
                    $user = User::create([
                        'name' => $validated['name'],
                        'email' => $validated['email'],
                        'password' => Hash::make(Str::random(16)),
                        'is_guest' => 1,
                        'is_active' => 1,
                    ]);
                }

                $address = Address::create([
                    'user_id' => $user->id,
                    'name' => 'Default Address',
                    'address' => $validated['address'],
                    'city_id' => $validated['city_id'],
                    'province_id' => $validated['province_id'],
                    'country_id' => $validated['country_id'],
                    'phone' => $validated['phone'],
                    'is_default' => 1
                ]);

                $billingAddressId = $address->id;
                $shippingAddressId = $address->id;
            } else {
                $billingAddressId = $validated['billing_address_id'];
                $shippingAddressId = $validated['shipping_address_id'];
            }

            $order = Order::create([
                'order_number' => Str::uuid(),
                'user_id' => $user->id,
                'billing_address_id' => $billingAddressId,
                'shipping_address_id' => $shippingAddressId,
                'email' => $user->email,
                'payment_method' => $validated['payment_method'],
                'payment_status' => 'pending',
                'status' => 'placed',
                'sub_total' => $cartData['subTotal'],
                'tax' => $cartData['tax'],
                'total' => $cartData['total'],
                // 'currency_id' => ..., // if currency is required
            ]);

            foreach ($cartData['items'] as $variantId => $item) {
                OrderLineItem::create([
                    'order_id' => $order->id,
                    'product_variant_id' => $variantId,
                    'quantity' => $item['qty'],
                    'price' => $item['price'],
                    'total' => $item['subtotal'],
                ]);
            }

            $couponData = $cartData['coupon'];
            if ($couponData) {
                CouponUsage::create([
                    'coupon_id' => $couponData['id'],
                    'user_id' => $user->id,
                    'order_id' => $order->id,
                ]);
            }

            $this->cartService->clear();

            DB::commit();

            return response()->json([
                'message' => 'Order placed successfully',
                'order' => $order->fresh(['lineItems.productVariant.product'])
            ]);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'message' => 'Checkout failed',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
