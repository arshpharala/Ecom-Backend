<div class="form-group">
  <label for="name">Name</label>
  <input type="text" name="name" class="form-control" value="{{ old('name', $packaging->name ?? '') }}"
    required>
</div>

<div class="form-group">
  <label for="description">Description</label>
  <textarea name="description" rows="3" class="form-control">{{ old('description', $packaging->description ?? '') }}</textarea>
</div>

<div class="form-row">
  <div class="form-group col-md-6">
    <label for="reference_id">Reference ID</label>
    <input type="number" name="reference_id" class="form-control"
      value="{{ old('reference_id', $packaging->reference_id ?? '') }}">
  </div>

  <div class="form-group col-md-6">
    <label for="reference_name">Reference Name</label>
    <input type="text" name="reference_name" class="form-control"
      value="{{ old('reference_name', $packaging->reference_name ?? '') }}">
  </div>
</div>

<div class="form-group">
  <label>
    <input type="checkbox" name="is_active" value="1"
      {{ isset($packaging) ? ($packaging->is_active ? 'checked' : '') : 'checked' }}>
    Active
  </label>
</div>
