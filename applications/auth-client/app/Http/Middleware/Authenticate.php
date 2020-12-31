<?php

namespace App\Http\Middleware;

use App\Models\User;
use Illuminate\Auth\Middleware\Authenticate as Middleware;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log; //TODO: delete

class Authenticate extends Middleware
{
    /**
     * Get the path the user should be redirected to when they are not authenticated.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return string|null
     */
    protected function redirectTo($request)
    {
        if (! $request->expectsJson()) {
            Log::debug('!$request->expectsJson() ' .
                var_export(['req'=>$request->all()],true));
//            $userInfo = $request->get('userInfo');
//            if ($userInfo){
//                //$this->authenticate($request, ['name' => 'web']);
//                $user = new User();
//                $user->name  = $userInfo['username'];
//                $user->email = $userInfo['email'];
//                Auth::setUser($user);
//            }
//            //Log::debug(var_export(['check'=>Auth::check()],true));
//            Log::debug(var_export(['user1'=>Auth::user()->name],true));

//            if (!Auth::check()){
                //return route('login');
                return route('welcome');
//            }
        }
    }
}
