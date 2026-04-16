<?php

namespace App\Http\Controllers;

use App\groupOfFunctions;
use App\Http\Requests\AddApartmentRequest;
use App\Http\Resources\ApartmentResource;
use App\Models\Apartment;
use Illuminate\Support\Facades\Auth;

class ApartmentController extends Controller
{
    use groupOfFunctions;
     public function AddAppartment(AddApartmentRequest $request){
       $validated = $request->validated();
       $validated['renter_id']=Auth::user()->id;
       $apartment = Apartment::create($validated);
       return response()->json($apartment, 201);
    }
    public function ShowApartments(){
        $apartments = $this->showAllApartments();
        return ApartmentResource::collection($apartments);
    }
    public function removeApartment($id){
        $user_id = Auth::user()->id;
        $apartment = Apartment::findOrFail($id);
        if($user_id!=$apartment->renter_id){
            return response()->json('you con\'t remove this apartment', 401);
        }
        $apartment->delete();
        return response()->json('apartment deleted successfully', 200);
    }

     public function showByAddress($Address){
            $apartments = Apartment::where('address',$Address)->get();
            return response()->json($apartments, 200);
        }

     public function showByPrice($Price){
            $apartments = Apartment::where('cost','<=',$Price)->get();
            return response()->json($apartments, 200);
        }
        
     public function showByDescription($description){
            $apartments = Apartment::where('description',$description)->get();
            return response()->json($apartments, 200);
        }
}
