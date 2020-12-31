<?php

namespace App\Http\Controllers\Sso;

use App\Http\Controllers\Controller;
use App\Libs\Sso\CognitoAuthRequest;
use App\Libs\Sso\Trait\SsoRequestHelper;
use App\Providers\RouteServiceProvider;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log; //TODO: delete
use Psr\Http\Message\ResponseInterface;

/**
 * Class CognitoController
 * @package App\Http\Controllers\Sso
 */
class CognitoController extends Controller
{
    use SsoRequestHelper;

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = RouteServiceProvider::HOME;

    /** @var CognitoAuthRequest  */
    private CognitoAuthRequest $invoker;

    /**
     * CognitoController constructor.
     */
    public function __construct()
    {
        $this->invoker = new CognitoAuthRequest(null);
    }

    /**
     * @return RedirectResponse
     */
    public function login(): RedirectResponse
    {
        $state = $this->getStateUuid();
        //TODO: state をここでセッションに保存しておくなど適宜
        return redirect()->away(
            \urldecode($this->invoker->buildLoginRequest([
                'state'   => $state,
                'appUrl'  => config('app.url')
            ]))
        );
    }

    public function logout()
    {
        Log::debug('logout');
    }

    public function callback(Request $request)
    {
        //Token Request
        $tokenResponse = $this->invoker->invokeTokenRequest([
            'loginResult' => $request->all(),
            'appUrl'      => config('app.url')
        ]);
        $tokens = \json_decode(
            $tokenResponse->getBody()->getContents(), true
        );

        //UserInfo Request
        $userInfoResponse = $this->invoker->invokeUserInfoRequest([
            'headers' => [
                'Authorization' => 'Bearer ' . $tokens['access_token']
            ]
        ]);
        $userInfo = \json_decode(
            $userInfoResponse->getBody()->getContents(), true
        );

        //NOTE:
        //DBがあるならここで認証処理（Auth::login(<照合された User Model>)）
        //をしておくのが良さそう
        //そして、 redirect()->intended('/home'); するのがたぶん標準的な実装

        $request->session()->put('userInfo', $userInfo);
        return redirect()->route('home');

        //POST redirect -> これはできない
        //return redirect()->route('home',
        //    compact('userInfo')
        //);
    }
}
