<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\WorkController;



Route::middleware('auth')->group(function () {
    Route::get('/', [AuthController::class, 'index']);
});

Route::post('/workStart', [WorkController::class, 'store']);
Route::post('/workEnd', [WorkController::class, 'store_end']);
Route::get('/date', [WorkController::class, 'show']);
