<?php

namespace App\Libs\Sso\Trait;

use Illuminate\Support\Str;

/**
 * Trait SignInRequestBuilder
 * @package App\Lib\Sso
 */
trait SignInRequestBuilder
{
    /**
     * state 用に UUID（バージョン４）を取得する
     * @return string
     */
    public function getStateUuid(): string
    {
        return (string) Str::uuid();
    }

    /**
     * @param array $configs
     * @return string
     */
    public function buildCognitoSignInRequest(array $configs): string
    {
        return
            'https://' . $configs['cognito']['domain_prefix'] .
                '.auth.' . $configs['cognito']['region'] . '.amazoncognito.com/login'.
            '?client_id='. $configs['cognito']['app_client_id'] .
            '&redirect_uri='. $configs['appUrl'] .'/sso/cognito/callback' .     //pathは適宜調整
            '&response_type=code'.
            '&state=' . $configs['state'] .
            '&scope=aws.cognito.signin.user.admin+email+openid+phone+profile'
            ;
    }
}
