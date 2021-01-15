<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Libs\Sso\CognitoAuthRequest;
use App\Libs\Sso\Trait\SsoRequestHelper;
use App\Providers\RouteServiceProvider;
use Illuminate\Http\Request;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Support\Facades\Log;

class LoginController extends Controller
{
    use SsoRequestHelper;

    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    use AuthenticatesUsers;

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = RouteServiceProvider::HOME;

    /** @var CognitoAuthRequest  */
    private CognitoAuthRequest $invoker;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');

        //$this->invoker = new CognitoAuthRequest(null);
    }

    /**
     * Log the user out of the application.
     * (copy from vendor/laravel/ui/auth-backend/AuthenticatesUsers.php)
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\RedirectResponse|\Illuminate\Http\JsonResponse
     */
    public function logout(Request $request)
    {
        $this->guard()->logout();

        $request->session()->invalidate();

        $request->session()->regenerateToken();

        if ($response = $this->loggedOut($request)) {
            return $response;
        }

        return redirect()->route('sso.cognito.logout');

//        $logoutResp = $this->invoker->invokeLogoutRequest([
//            'state'  => $this->getStateUuid(),
//            'appUrl' => config('app.url')
//        ]);
//        Log::debug(var_export([
//            'status' => $logoutResp->status(),
//            //'body' => $logoutResp->body(),
//        ], true));
//
//        return $request->wantsJson()
//            ? new JsonResponse([], 204)
//            : redirect('/');
    }
}
