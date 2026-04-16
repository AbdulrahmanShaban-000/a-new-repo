<?php

use App\Http\Controllers\ClientController;
use App\Http\Controllers\UserController;
use App\Models\Client;
use App\Models\Financial;
use App\Models\User;
use Illuminate\Support\Facades\Route;

// Route::get('/', function () {
//     return view('welcome');
// });
// Route::get('/users&tasks',[UserController::class,'getUserWithTask']);





Route::get('/',[UserController::class,'index']);
Route::get('/{value}',[ClientController::class,'Financial_request']);

Route::post('/approve/{id}',[UserController::class,'Register'])->name('storeClient');
Route::delete('/reject/{id}',function($id){
    $client = Client::findOrFail($id);
    $client->delete();
    return redirect()->back();
})->name('deleteClient');


Route::delete('/delete/{id}',[UserController::class,'destroy'])->name('deleteUser');

Route::get('/profileClient/{id}', function ($id) {
    $client = Client::findOrFail($id);
    return view('blade.details',compact('client'));
})->name('detailsClient.show');

Route::get('/profileUser/{id}', function ($id) {
    $client = User::findOrFail($id);
    return view('blade.details',compact('client'));
})->name('detailsUser.show');


Route::post('/approveRequest/{id}/{client_id}/{value}',function($request_id,$client_id,$value){
    $client = User::findOrFail($client_id);
    $client->wallet+=$value;
    $client->save();
    Financial::findOrFail($request_id)->delete();
    return redirect()->back();
})->name('Yes');
Route::delete('/rejectRequest/{id}',function($request_id){
    Financial::findOrFail($request_id)->delete();
    return redirect()->back();
})->name('No');
