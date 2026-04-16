<?php

namespace App\Http\Middleware;

use App\Models\Reservation;
use Carbon\Carbon;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class Date_Rating
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        $now = Carbon::now();
        $reserve = Reservation::where('tenant_id',Auth::user()->id)->firstOrFail();
        if($reserve->end_date < $now){
            return response()->json('you conn\'t rating now , try after end of your reservation', 400);
        }
        return $next($request);
    }
}
