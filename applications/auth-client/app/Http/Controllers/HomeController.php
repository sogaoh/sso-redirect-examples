<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log; //TODO: delete

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        //NOTE:
        //通常は認証されてくるが、このアプリはDBなしにあえてしているので
        //Middleware を外して Controller 内で認証処理をする（普通は絶対にやっちゃダメ）

        //$this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @param Request $request
     * @return \Illuminate\Contracts\Support\Renderable
     */
    //public function index()
    public function index(Request $request)
    {
        $userName = '';
        $userInfo = $request->session()->get('userInfo');
        if ($userInfo) {
            $ssoUser = new User();
            $ssoUser->name  = $userName = $userInfo['username'];
            $ssoUser->email = $userInfo['email'];
            Auth::setUser($ssoUser);
            //↓コメントアウトにしないとリロードで強制ログアウトになる
            //$request->session()->flush();
        }

        $currentUser = Auth::user();
        if ($currentUser && $currentUser->name === $userName) {
            return view('home');
        } else {
            return redirect()->route('welcome');
        }
    }
}
