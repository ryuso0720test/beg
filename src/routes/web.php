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
Route::get('/attendance', [WorkController::class, 'show']);
Route::get('/attendance/date-next', [WorkController::class, 'dateNext']);
Route::get('/attendance/date-pre', [WorkController::class, 'datePre']);

Route::get('/attendance/date-next/user/{id}', [WorkController::class, 'dateNextUser']);
Route::get('/attendance/date-pre/user/{id}', [WorkController::class, 'datePreUser']);

Route::get('/userList', [WorkController::class, 'userList']);
Route::get('/attendance/{id}', [WorkController::class, 'user_date']);
Route::post('/restStart', [RestController::class, 'storeRest']);
Route::post('/restEnd', [RestController::class, 'updateRest']);