<?php

namespace App\Libs\Sso;

/**
 * Class CognitoRequestBuilder
 * @package Libs\Sso
 */
class CognitoRequestBuilder
{
    /** @var array Cognito設定 */
    private array $config;

    /**
     * CognitoRequestBuilder constructor.
     */
    public function __construct()
    {
        $this->config = config('sso-cognito');
    }

    /**
     * @param array $configs
     * @return string
     */
    public function getSignInRequest(array $configs): string
    {
        return
            'https://' . $this->config['domain_prefix'] .
                '.auth.' . $this->config['region'] . '.amazoncognito.com/login'.
            '?client_id='. $this->config['app_client_id'] .
            '&redirect_uri='. $configs['appUrl'] .'/sso/cognito/callback' .     //pathは適宜調整
            '&response_type=code'.
            '&state=' . $configs['state'] .
            '&scope=aws.cognito.signin.user.admin+email+openid+phone+profile'
            ;
    }
}
