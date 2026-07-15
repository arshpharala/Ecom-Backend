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

        return response()->json([
            'success' => true,
            'data' => [
                'countries' => $countries,
                'brands' => $brands,
                'categories' => $categories,
                'tags' => $tags,
            ]
        ]);
    }
}
