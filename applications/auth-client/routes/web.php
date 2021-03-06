<?php

use App\Http\Controllers\HomeController;
use App\Http\Controllers\Sso\CognitoController;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\URL;

if (!App::environment('local')) {
    URL::forceScheme('https');
}

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
})->name('welcome');

Auth::routes([
    //'login' => false,
    'register' => false,
    'reset' => false,
    'confirm' => false,
    'verify' => false
]);

Route::group(['prefix' => 'sso'], function () {
    Route::group(['prefix' => 'cognito'], function () {
        Route::get('/login',  [CognitoController::class, 'login'])
            ->name('sso.cognito.login');
        Route::get('/logout', [CognitoController::class, 'logout'])
            ->name('sso.cognito.logout');
        Route::get('/callback', [CognitoController::class, 'callback'])
            ->name('sso.cognito.callback');
    });
});

//Route::match(['get', 'post'],
Route::get(
    '/home', [HomeController::class, 'index']
)->name('home');
