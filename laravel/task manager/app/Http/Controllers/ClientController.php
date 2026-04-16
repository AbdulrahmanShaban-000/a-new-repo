<?php

namespace App\Http\Controllers;

use App\groupOfFunctions;
use App\Http\Requests\AddClientRequest;
use App\Http\Requests\ReserveRequest;
use App\Http\Requests\UpdateReserveRequest;
use App\Models\Apartment;
use App\Models\Client;
use App\Models\Financial;
use App\Models\Rating;
use App\Models\Reservation;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ClientController extends Controller
{
    use groupOfFunctions;

    public function store(AddClientRequest $request)
    {
        $valideted = $request->validated();
        if ($request->hasFile('personal_photo')) {
            $path = $request->file('personal_photo')->store('personal photo', 'public');
            $valideted['personal_photo'] = $path;
        }
        if ($request->hasFile('An_ID_photo')) {
            $path = $request->file('An_ID_photo')->store('An ID photo', 'public');
            $valideted['An_ID_photo'] = $path;
        }
        $client = Client::create($valideted);
        return response()->json('The request has been sent', 201);
    }

    //////////////////////////////////////////////////////////////////////////////
    public function loginForClient(Request $request)
    {
        return $this->login($request);
    }
    public function LogoutForClient(Request $request)
    {
        return $this->Logout($request);
    }

    public function showRequestForRenter()
    {
        $apartmentsIds = Apartment::where('renter_id', Auth::user()->id)->pluck('id');
        $request = Reservation::where('status', 'pending')
            ->whereIn('apartment_id', $apartmentsIds)->get();
        return response()->json($request, 200);
    }
    ///////////////////////////////////////////////////////////////////////////////
    public function approve($id)
    {
        $reservation = Reservation::findOrFail($id);
        $reservation->status = 'approved';
        $reservation->save();
        return response()->json('request approved', 200);
    }
    ///////////////////////////////////////////////////////////////////////////////
    public function reject($id)
    {
        $reservation = Reservation::findOrFail($id);
        $apartment = Apartment::findOrFail($reservation->apartment_id);
        $tenant = User::findOrFail($reservation->tenant_id);
        $renter = User::findOrFail($apartment->renter_id);

        $tenant->wallet += $apartment->cost;
        $tenant->save();
        $renter->wallet -= $apartment->cost;
        $renter->save();
        $reservation->status = 'cancelled';
        $reservation->save();
        return response()->json('request rejected', 200);
    }
    ///////////////////////////////////////////////////////////////////////////////
    public function reserve(ReserveRequest $request, $ApartmentId)
    {

        $validated = $request->validated();
        return DB::transaction(function () use ($validated, $ApartmentId) {

            $apartment = Apartment::where('id', $ApartmentId)
                ->lockForUpdate()
                ->firstOrFail();

            $overlapping = Reservation::where('apartment_id', $ApartmentId)
                ->whereIn('status', ['pending', 'approved'])
                ->where(function ($q) use ($validated) {
                    $q->where('start_date', '<=', $validated['end_date'])
                        ->where('end_date', '>=', $validated['start_date']);
                })
                ->lockForUpdate()
                ->exists();

            if ($overlapping) {
                return response()->json([
                    'message' => 'Sorry, there is another booking within the same time period.',
                ], 409);
            } else {
                $renter_id = $apartment->renter_id;
                $tenant_id = Auth::user()->id;
                if ($this->Payment_process($tenant_id, $renter_id, $apartment->cost)) {
                    Reservation::create([
                        'tenant_id' => Auth::user()->id,
                        'apartment_id' => $ApartmentId,
                        'start_date' => $validated['start_date'],
                        'end_date' => $validated['end_date']
                    ]);
                    return response()->json('apartment reserved successfully', 200);
                } else {
                    return response()->json(['message' => 'your wallet content is less than cost this apartment'], 400);
                }
            }
        });
    }


    public function updateDateOfReservation(UpdateReserveRequest $request, $Id)
    {
        $validated = $request->validated();
        $user_id = Auth::user()->id;
        $reservation = Reservation::findOrFail($Id);
        if ($reservation->tenant_id != $user_id) {
            return response()->json(['message' => 'Unauthenticated'], 401);
        }

        $overlapping = Reservation::where(function ($q) use ($validated) {
            $q->where('start_date', '<=', $validated['end_date'])
                ->where('end_date', '>=', $validated['start_date'])
                ->where('tenant_id', '!=', Auth::user()->id)
                ->whereIn('status', ['pending', 'approved']);
        })
            ->lockForUpdate()
            ->exists();

        if ($overlapping) {
            return response()->json([
                'message' => 'Sorry, there is another booking within the same time period.',
            ], 409);
        } else {
            $reservation->status = 'pending';
            $reservation->update($request->only(['start_date', 'end_date']));
        }
        return response()->json('reserve updated successfully', 200);
    }

    public function updateStatusOfReservation(Request $request, $Id)
    {
        $validated = $request->validate([
            'status' => 'required|in:"pending","cancelled","approved"'
        ]);
        $user_id = Auth::user()->id;
        $reservation = Reservation::findOrFail($Id);
        if ($reservation->tenant_id != $user_id) {
            return response()->json(['message' => 'Unauthenticated'], 401);
        }
        $reservation->update($request->only('status'));
        return response()->json('reserve updated successfully', 200);
    }

    public function showAllReservation()
    {
        $user_id = Auth::user()->id;
        $reservations = Reservation::where('tenant_id', $user_id)->get();
        return response()->json($reservations, 200);
    }

    ///////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////

    public function Financial_request($value)
    {
        $user_id = Auth::user()->id;
        $client = User::findOrFail($user_id);
        Financial::create([
            'client_id' => $user_id,
            'name' => $client->first_name . " " . $client->last_name,
            'value' => $value
        ]);
        return response()->json('The request has been sent', 200);
    }

    //////////////////////////////////////////////////////////////////////
    public function addRating(Request $request, $ReserveId)
    {
        $reservation = Reservation::findOrFail($ReserveId);
        if ($reservation->tenant_id != Auth::user()->id) {
            return response()->json(['message' => 'Unauthenticated'], 401);
        }
        $validated = $request->validate([
            'rating' => 'required|min:1|max:5'
        ]);
        $validated['reservation_id'] = $ReserveId;
        Rating::create($validated);
        return response()->json(['message' => 'your rating has been add ,thank you'], 201);
    }
    ////////////////////////////////////////////////////////////////////////
    public function AddToFavorite($ApartmentId)
    {
        Apartment::findOrFail($ApartmentId);
        Auth::user()->favoriteApartments()->syncWithoutDetaching($ApartmentId);
        return response()->json(['massege' => 'Apartment Added to favorite'], 200);
    }
    public function RemoveFromFavorite($ApartmentId)
    {
        Apartment::findOrFail($ApartmentId);
        Auth::user()->favoriteApartments()->detach($ApartmentId);
        return response()->json(['massege' => 'Apartment removed from favorite'], 200);
    }

    public function getApartmentsFavorite()
    {
        $tasksFavorite = Auth::user()->favoriteApartments;
        return response()->json($tasksFavorite, 200);
    }
}
