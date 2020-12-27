<?php

namespace App\Http\Controllers\Sso;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

/**
 * Class CognitoController
 * @package App\Http\Controllers\Sso
 */
class CognitoController extends Controller
{
    public function index()
    {
        return view('sso.cognito.index');
    }

    public function login(Request $request)
    {
    }

    public function logout()
    {
    }

    public function callback()
    {
    }
}
