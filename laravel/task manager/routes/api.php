<?php

use App\Http\Controllers\ApartmentController;
use App\Http\Controllers\ClientController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');
Route::prefix('client')->controller(ClientController::class)->group(function () {

    Route::post('/add', 'store');
    Route::post('/Login', 'loginForClient');

    Route::middleware('auth:sanctum')->group(function () {
        Route::post('/Logout', 'LogoutForClient');


        Route::post('/Favorite/{ID}', 'AddToFavorite')->middleware('Tenant');
        Route::delete('/Favorite/{ID}', 'RemoveFromFavorite')->middleware('Tenant');
        Route::get('/Favorites', 'getApartmentsFavorite')->middleware('Tenant');

        Route::put('/approveReservation/{id}', 'approve')->middleware('Renter');
        Route::put('/rejectReservation/{id}', 'reject')->middleware('Renter');
        Route::get('/showRequest', 'showRequestForRenter')->middleware('Renter');

        Route::post('/reservation/{Id}', 'reserve')->middleware('Tenant');
        Route::get('/reservation', 'showAllReservation')->middleware('Tenant');
        Route::put('/updateDate/{Id}', 'updateDateOfReservation')->middleware('Tenant');
        Route::put('/updateStatus/{Id}', 'updateStatusOfReservation')->middleware('Tenant');


        Route::post('/rating/{id}', 'addRating')->middleware(['Tenant', 'Rating']);


        Route::post('/sentFinancialRequest/{value}', 'Financial_request')->middleware('Tenant');
    });


});

Route::prefix('apartment')->controller(ApartmentController::class)->middleware('auth:sanctum')->group(function () {

    Route::get('/getApartments', 'ShowApartments');
    Route::post('/newApartment', 'AddAppartment')->middleware('Renter');
    Route::delete('/deleteApartment/{id}', 'removeApartment')->middleware('Renter');
    Route::get('/showByAdd/{Address}', 'showByAddress');
    Route::get('/showByPri/{Price}', 'showByPrice');
    Route::get('/showByDes/{Description}', 'showByDescription');

});