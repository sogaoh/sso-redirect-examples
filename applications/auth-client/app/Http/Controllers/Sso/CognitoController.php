<?php

namespace App\Http\Controllers\Sso;

use App\Http\Controllers\Controller;
use App\Libs\Sso\CognitoAuthRequest;
use App\Libs\Sso\Trait\SsoRequestHelper;
use Illuminate\Http\Request;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Log; //TODO: delete
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
        var_dump($request->all());
        Log::debug('callback');
    }
}
