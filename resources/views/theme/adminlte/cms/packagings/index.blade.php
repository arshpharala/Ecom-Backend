@extends('theme.adminlte.layouts.app')
@section('content-header')
  <div class="row mb-2">
    <div class="col-sm-6">
      <h1>@lang('crud.list_title', ['name' => 'Packaging'])</h1>
    </div>
    <div class="col-sm-6 d-flex flex-row justify-content-end gap-2">
      @can('create', App\Models\CMS\Packaging::class)
        <button data-url="{{ route('admin.cms.packagings.create') }}" type="button" class="btn btn-secondary"
          onclick="getAside()"><i class="fa fa-plus"></i> @lang('crud.create')</button>
      @endcan
    </div>
  </div>
@endsection
@section('content')
  <div class="card">
    <div class="card-body">
      <table class="table table-bordered data-table">
        <thead>
          <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Reference ID</th>
            <th>Reference Name</th>
            <th>Status</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody></tbody>
      </table>
    </div>
  </div>
@endsection
@push('scripts')
  <script>
    $(function() {
      $('.data-table').DataTable({
        processing: true,
        serverSide: true,
        ajax: '{{ route('admin.cms.packagings.index') }}',
        columns: [{
            data: 'name',
            name: 'name'
          },
          {
            data: 'description',
            name: 'description',
          },
          {
            data: 'reference_id',
            name: 'reference_id',
          },
          {
            data: 'reference_name',
            name: 'reference_name',
          },
          {
            data: 'is_active',
            name: 'is_active'
          },
          {
            data: 'action',
            name: 'action',
            orderable: false,
            searchable: false
          }
        ]
      });
    });
  </script>
@endpush
