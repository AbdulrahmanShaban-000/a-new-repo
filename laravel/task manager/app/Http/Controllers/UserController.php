<?php

namespace App\Http\Controllers;
use App\Models\Client;
use App\Models\Financial;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
      public function Register($id){
        
        $client = Client::findOrFail($id);
        if($client->role=='tenant'){
            $client->wallet = 5000;
        }else
            $client->wallet = 0;

        User::create([
            'first_name'=>$client->first_name,
            'last_name'=>$client->last_name,
            'phone'=>$client->phone,
            'password'=>Hash::make($client->password),
            'role'=>$client->role,
            'personal_photo'=>$client->personal_photo,
            'date_of_birth'=>$client->date_of_birth,
            'An_ID_photo'=>$client->An_ID_photo,
            'wallet'=>$client->wallet
        ]);
        $client->delete();
        return redirect()->back();
    }

   
    public function index(){
        $clients = Client::all();
        $numberOfClients =Client::count();
        $users = User::all();
        $numberOfUsers = User::count();
        $requests = Financial::all();
        return view('blade.dashboard',compact(['clients','users','numberOfClients','numberOfUsers','requests']));
    }
    public function destroy($id){
        User::findOrFail($id)->delete();
        return redirect()->back();
    }
}