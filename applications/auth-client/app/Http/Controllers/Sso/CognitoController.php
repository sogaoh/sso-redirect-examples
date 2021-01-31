<?php

namespace App\Http\Controllers\Sso;

use App\Http\Controllers\Controller;
use App\Libs\Sso\CognitoAuthRequest;
use App\Libs\Sso\Trait\SsoRequestHelper;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;

/**
 * Class CognitoController
 * @package App\Http\Controllers\Sso
 */
class CognitoController extends Controller
{
    use SsoRequestHelper;

    /** @var string STATE_CACHE_IDENTIFIER */
    const STATE_CACHE_IDENTIFIER = 'stateCache';

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
        Log::debug('+++++ called Cognito # login +++++');

        $state = $this->getStateUuid();

        // state を 90秒間保存
        Cache::store(self::STATE_CACHE_IDENTIFIER)->add(
            $state,
            Carbon::now()->format('Y-m-d H:i:s'),
            90
        );

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
        Log::debug('..... Cognito # logout .....');

        $state = $this->getStateUuid();

        // state を 90秒間保存
        Cache::store(self::STATE_CACHE_IDENTIFIER)->add(
            $state,
            Carbon::now()->format('Y-m-d H:i:s'),
            90
        );

        return redirect()->away(
            \urldecode($this->invoker->buildLogoutRequest([
                'state'   => $state,
                'appUrl'  => config('app.url')
            ]))
        );
    }

    /**
     * @param Request $request
     * @return RedirectResponse
     * @throws \Psr\SimpleCache\InvalidArgumentException
     */
    public function callback(Request $request)
    {
        Log::debug('>>>>> Cognito # callback >>>>>');

        $warningDateTime = '';
        // state のチェック
        $cachedState = Cache::store(self::STATE_CACHE_IDENTIFIER)->get(
            $request->get('state')
        );
        if ($cachedState === null) {
            //あとでワーニングをログに出すだけ
            $warningDateTime = Carbon::now()->format('Y-m-d H:i:s');
        }

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
        $decodedUser = \json_decode(
            $userInfoResponse->body(), true
        );
        $userInfo = \is_array($decodedUser) ? $decodedUser : [];

        //setUser
        $user = $this->getAuthorizedUser($userInfo);
        Auth::setUser($user);

        //State Not Found warning log
        if (\mb_strlen($warningDateTime) > 0) {
            Log::warning(
                '*** State Not Found: userId=' . $user->id .
                ', datetime='. $warningDateTime
            );
        }

        return redirect()->route('home');
    }

    /**
     * @param array $userInfo
     * @return User
     */
    private function getAuthorizedUser(array $userInfo): User
    {
        $q = User::query();
        $q->where('email', $userInfo['email']);
        $user = $q->first();

        if (!$user) {
            $user = User::create([
                'name' => $userInfo['username'],
                'email' => $userInfo['email'],
                'cognito_sub' => $userInfo['sub']
            ]);
        }

        return $user;
    }
}
