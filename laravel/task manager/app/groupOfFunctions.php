<?php

namespace App;

use App\Models\Apartment;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

trait groupOfFunctions
{
    public function login(Request $request)
    {
        $request->validate([
            'phone' => 'required',
            'password' => 'required'
        ]);

        $credentials = [
            'phone' => $request->phone,
            'password' => $request->password,
        ];

        if (!Auth::attempt($credentials)) {
            return response()->json([
                'message' => 'Invalid phone or password'
            ], 403);
        }

        $user = User::where('phone', $request->phone)->firstOrFail();
        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'message' => 'Login successfully',
            'user' => $user,
            'token' => $token
        ], 200);
    }

    public function sign_up(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return response()->json(['message' => 'Logout successfully'], 200);
    }
    public function showAllApartments()
    {
        return Apartment::all();
    }

    public function Payment_process($tenant_id, $renter_id, $cost)
    {
        $tenant = User::findOrFail($tenant_id);
        $renter = User::findOrFail($renter_id);
        if ($tenant->wallet < $cost) {
            return false;
        } else {
            $renter->wallet += $cost;
            $renter->save();
            $tenant->wallet -= $cost;
            $tenant->save();
            return true;
        }
    }
}
