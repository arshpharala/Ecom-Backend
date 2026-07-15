<?php

namespace App\Http\Controllers\API\V1;

use App\Http\Controllers\Controller;
use App\Models\CMS\Country;
use App\Models\CMS\Province;
use App\Models\Catalog\Brand;
use App\Models\Catalog\Category;
use App\Models\CMS\Tag;
use Illuminate\Http\JsonResponse;

class CoreApiController extends Controller
{
    /**
     * Get all necessary initialization data for the frontend (select boxes, filters, etc).
     *
     * GET /api/v1/init
     */
    public function init(): JsonResponse
    {
        $countries = Country::with(['provinces.cities.areas'])->get();
        
        $brands = Brand::active()->orderBy('position')->get();
        
        $categories = Category::withJoins()
            ->visible()
            ->withSelection()
            ->orderBy('categories.position')
            ->get();
            
        $tags = Tag::active()->orderBy('position')->get();

        $settings = [
            'contact_number' => setting('contact_phone'),
            'contact_email' => setting('contact_email'),
            'social_links' => [
                'facebook' => setting('facebook'),
                'instagram' => setting('instagram'),
                'linkedin' => setting('linkedin'),
                'pinterest' => setting('pinterest'),
                'twitter' => setting('twitter'),
            ],
            'footer_details' => setting('copyright'),
            'logo' => setting('site_logo') ? asset(setting('site_logo')) : null,
            'footer_logo' => setting('site_footer_logo') ? asset(setting('site_footer_logo')) : null,
            'favicon' => setting('site_favicon') ? asset(setting('site_favicon')) : null,
            'site_name' => setting('site_title'),
            'address' => setting('address'),
            'map_link' => setting('show_office_map') ? setting('office_map_embed') : null,
            'contact_subjects' => setting('contact_subjects') ? array_values(array_filter(array_map('trim', explode("\n", setting('contact_subjects'))))) : [],
        ];

        return response()->json([
            'success' => true,
            'data' => [
                'countries' => $countries,
                'brands' => $brands,
                'categories' => $categories,
                'tags' => $tags,
                'settings' => $settings,
            ]
        ]);
    }
}
