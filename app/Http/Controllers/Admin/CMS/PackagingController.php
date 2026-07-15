<?php

namespace App\Http\Controllers\Admin\CMS;

use Illuminate\Http\Request;
use App\Models\CMS\Packaging;
use App\Http\Controllers\Controller;
use Yajra\DataTables\Facades\DataTables;
use App\Http\Requests\StorePackagingRequest;
use App\Http\Requests\UpdatePackagingRequest;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;

class PackagingController extends Controller
{
    use AuthorizesRequests;
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $this->authorize('viewAny', Packaging::class);

        if ($request->ajax()) {
            $packagings = Packaging::query();

            return DataTables::of($packagings)
                ->addColumn('action', function ($row) {
                    $editUrl = route('admin.cms.packagings.edit', $row->id);
                    $deleteUrl = route('admin.cms.packagings.destroy', $row->id);
                    $editSidebar = true;
                    return view('theme.adminlte.components._table-actions', compact('editUrl', 'deleteUrl', 'row', 'editSidebar'))->render();
                })
                ->addColumn('is_active', fn($row) => $row->is_active ? '<span class="badge badge-success">Active</span>' : '<span class="badge badge-danger">Inactive</span>')
                ->rawColumns(['action', 'is_active'])
                ->make(true);
        }
        return view('theme.adminlte.cms.packagings.index');
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $this->authorize('create', Packaging::class);

        $data['packaging'] = new Packaging();
        $response['view'] =  view('theme.adminlte.cms.packagings.create', $data)->render();

        return response()->json([
            'success' => true,
            'data' => $response
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StorePackagingRequest $request)
    {
        $this->authorize('create', Packaging::class);

        $validated = $request->validated();

        Packaging::create([
            'name'           => $validated['name'],
            'description'    => $validated['description'] ?? null,
            'is_active'      => $validated['is_active'] ?? false,
            'reference_id'   => $validated['reference_id'] ?? null,
            'reference_name' => $validated['reference_name'] ?? null,
        ]);

        return response()->json([
            'message'   => __('crud.created', ['name' => 'Packaging']),
            'redirect' => route('admin.cms.packagings.index')
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $packaging = Packaging::findOrFail($id);

        $this->authorize('update', $packaging);

        $data['packaging'] = $packaging;

        $response['view'] =  view('theme.adminlte.cms.packagings.edit', $data)->render();

        return response()->json([
            'success' => true,
            'data' => $response
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdatePackagingRequest $request, string $id)
    {
        $packaging = Packaging::findOrFail($id);

        $this->authorize('update', $packaging);

        $validated = $request->validated();

        $packaging->update([
            'name'           => $validated['name'],
            'description'    => $validated['description'] ?? null,
            'is_active'      => $validated['is_active'] ?? false,
            'reference_id'   => $validated['reference_id'] ?? null,
            'reference_name' => $validated['reference_name'] ?? null,
        ]);

        return response()->json([
            'message'   => __('crud.updated', ['name' => 'Packaging']),
            'redirect'  => route('admin.cms.packagings.index')
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $packaging = Packaging::findOrFail($id);

        $this->authorize('delete', $packaging);

        $packaging->delete();

        return response()->json([
            'message'   => __('crud.deleted', ['name' => 'Packaging']),
            'redirect'  => route('admin.cms.packagings.index')
        ]);
    }
}
