<?php

namespace App\Http\Controllers\Sso;

use App\Http\Controllers\Controller;
use App\Libs\Sso\CognitoAuthRequest;
use App\Libs\Sso\Trait\SsoRequestHelper;
use Illuminate\Http\Client\Response;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;
use Psr\Http\Message\ResponseInterface;

/**
 * Class CognitoController
 * @package App\Http\Controllers\Sso
 */
class CognitoController extends Controller
{
    use SsoRequestHelper;

    /** @var CognitoAuthRequest  */
    private CognitoAuthRequest $invoker;

    /**
     * CognitoController constructor.
     */
    public function __construct()
    {
        $this->invoker = new CognitoAuthRequest();
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

    /**
     * @return RedirectResponse
     */
    public function logout(): RedirectResponse
    {
        $state = $this->getStateUuid();
        //TODO: state をここでセッションに保存しておくなど適宜
        return redirect()->away(
            \urldecode($this->invoker->buildLogoutRequest([
                'state'   => $state,
                'appUrl'  => config('app.url')
            ]))
        );
    }

    /**
     * @param Request $request
     * @return mixed
     */
    public function callback(Request $request)
    {
        //TODO: state のチェック

        //Token Request
        $tokenResponse = $this->invoker->invokeTokenRequest([
            'loginResult' => $request->all(),
            'appUrl'      => config('app.url')
        ]);
        $tokens = \json_decode(
            $tokenResponse->body(), true
        );

        //UserInfo Request
        $userInfoResponse = $this->invoker->invokeUserInfoRequest([
            'access_token' => $tokens['access_token']
        ]);
        $userInfo = \json_decode(
            $userInfoResponse->body(), true
        );

        //NOTE:
        //DBがあるならここで認証処理（Auth::login(<照合された User Model>)）
        //をしておくのが良さそう
        //そして、 redirect()->intended('/home'); するのがたぶん標準的な実装

        $request->session()->put('userInfo', $userInfo);
        return redirect()->route('home');
    }
}
