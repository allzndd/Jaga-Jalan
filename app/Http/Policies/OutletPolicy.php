<?php

namespace App\Policies;

use App\Models\User;
use App\Models\Outlet;
use Illuminate\Auth\Access\HandlesAuthorization;

class OutletPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view the outlet.
     *
     * @param \App\Models\User $user
     * @param \App\Models\Outlet $outlet
     * @return mixed
     */
    public function view(User $user, Outlet $outlet)
    {
        // Update user authorization to view the outlet here.
        return true;
    }

    /**
     * Determine whether the user can create an outlet.
     *
     * @param \App\Models\User $user
     * @return mixed
     */
    public function create(User $user)
    {
        // Update user authorization to create an outlet here.
        return true;
    }

    /**
     * Determine whether the user can update the outlet.
     *
     * @param \App\Models\User $user
     * @param \App\Models\Outlet $outlet
     * @return mixed
     */
    public function update(User $user, Outlet $outlet)
    {
        // Update user authorization to update the outlet here.
        return true;
    }

    /**
     * Determine whether the user can delete the outlet.
     *
     * @param \App\Models\User $user
     * @param \App\Models\Outlet $outlet
     * @return mixed
     */
    public function delete(User $user, Outlet $outlet)
    {
        // Update user authorization to delete the outlet here.
        return true;
    }
}
