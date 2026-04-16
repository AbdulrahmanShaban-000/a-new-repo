<?php

use App\Http\Middleware\Date_Rating;
use App\Http\Middleware\Role_Renter;
use App\Http\Middleware\Role_Tenant;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {
       $middleware->alias([
        'Renter'=>Role_Renter::class,
        'Tenant'=>Role_Tenant::class,
        'Rating'=>Date_Rating::class
       ]);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        //
    })->create();
