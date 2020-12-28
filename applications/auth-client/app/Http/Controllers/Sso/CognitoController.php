<?php

namespace App\Http\Controllers\Sso;

use App\Http\Controllers\Controller;
use App\Libs\Sso\Trait\SignInRequestBuilder;
use Illuminate\Http\Request;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Log; //TODO: delete

/**
 * Class CognitoController
 * @package App\Http\Controllers\Sso
 */
class CognitoController extends Controller
{
    use SignInRequestBuilder;

    /** @var array Cognito設定 */
    private array $config;

    /**
     * CognitoController constructor.
     */
    public function __construct()
    {
        $this->config = config('sso-cognito');
    }

    /**
     * @return RedirectResponse
     */
    public function login(): RedirectResponse
    {
        $state = $this->getStateUuid();
        //TODO: state をここでセッションに保存しておくなど適宜
        return redirect()->away(
            $this->buildCognitoSignInRequest([
                'cognito' => $this->config,
                'state'   => $state,
                'appUrl'  => config('app.url')
            ])
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
