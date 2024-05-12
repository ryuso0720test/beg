<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\WorkController;
use App\Http\Controllers\RestController;



Route::middleware('auth')->group(function () {
    Route::get('/', [AuthController::class, 'index']);
});

Route::post('/workStart', [WorkController::class, 'store']);
Route::post('/workEnd', [WorkController::class, 'store_end']);
Route::get('/date', [WorkController::class, 'show']);
Route::get('/userList', [WorkController::class, 'userList']);

Route::post('/restStart', [RestController::class, 'storeRest']);
Route::post('/restEnd', [RestController::class, 'updateRest']);