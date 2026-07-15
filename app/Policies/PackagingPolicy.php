<?php

namespace App\Policies;

use App\Models\Admin;
use App\Models\CMS\Packaging;

class PackagingPolicy
{
    public function viewAny(Admin $admin): bool
    {
        return $admin->has_permission('Packaging', 'View List');
    }

    public function view(Admin $admin, Packaging $packaging): bool
    {
        return $admin->has_permission('Packaging', 'View');
    }

    public function create(Admin $admin): bool
    {
        return $admin->has_permission('Packaging', 'Create');
    }

    public function update(Admin $admin, Packaging $packaging): bool
    {
        return $admin->has_permission('Packaging', 'Update');
    }

    public function delete(Admin $admin, Packaging $packaging): bool
    {
        return $admin->has_permission('Packaging', 'Delete');
    }
}
