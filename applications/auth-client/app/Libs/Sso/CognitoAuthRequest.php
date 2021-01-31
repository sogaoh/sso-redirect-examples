<?php

namespace App\Libs\Sso;

use Illuminate\Http\Client\Response;
use Illuminate\Support\Facades\Http;

/**
 * Class CognitoAuthRequest
 * @package App\Libs\Sso
 */
class CognitoAuthRequest
{
    /** @var array Cognito設定 */
    private array $config;

    /** @var string Cognito Domain */
    private string $domain;

    /**
     * CognitoAuthRequest constructor.
     */
    public function __construct()
    {
        $this->config = config('sso-cognito');
        $this->domain = 'https://' . $this->config['domain_prefix'] .
            '.auth.' . $this->config['region'] . '.amazoncognito.com/';
    }

    /**
     * @param array $parameters
     * @return string
     */
    public function buildLoginRequest(array $parameters): string
    {
        return $this->domain . 'login?' .
            \http_build_query([
                'redirect_uri'  => $parameters['appUrl'] .'/sso/cognito/callback',     //pathは適宜調整
                'scope'         => 'aws.cognito.signin.user.admin+email+openid+phone+profile',
                'client_id'     => $this->config['app_client_id'],
                'state'         => $parameters['state'],
                'response_type' => 'code',
            ]);
    }

    /**
     * @param array $parameters
     * @return Response
     */
    public function invokeTokenRequest(array $parameters): Response
    {
        return Http::asForm()->post($this->domain . 'oauth2/token', [
            'grant_type'    => 'authorization_code',
            'client_id'     => $this->config['app_client_id'],
            'client_secret' => $this->config['app_client_secret'],
            'redirect_uri'  => $parameters['appUrl'] .'/sso/cognito/callback',     //pathは適宜調整
            'code'          => $parameters['loginResult']['code'],
        ]);
    }

    /**
     * @param array $parameters
     * @return Response
     */
    public function invokeUserInfoRequest(array $parameters): Response
    {
        return Http::withToken($parameters['access_token'])
            ->get($this->domain . 'oauth2/userInfo');
    }

    /**
     * @param array $parameters
     * @return string
     */
    public function buildLogoutRequest(array $parameters): string
    {
        return $this->domain . 'logout?' .
            \http_build_query([
                //'logout_uri' => $parameters['appUrl'] .'/sso/cognito/logout',  //pathは適宜調整
                'redirect_uri'  => $parameters['appUrl'] .'/sso/cognito/callback',     //pathは適宜調整
                'scope'         => 'aws.cognito.signin.user.admin+email+openid+phone+profile',
                'client_id'    => $this->config['app_client_id'],
                'state'         => $parameters['state'],
                'response_type' => 'code',
            ]);
    }

    /**
     * @param array $parameters
     * @return Response
     */
    public function invokeLogoutRequest(array $parameters): Response
    {
        return Http::get($this->domain . 'logout', [
            'client_id'    => $this->config['app_client_id'],
            //'logout_uri' => $parameters['appUrl'] .'/sso/cognito/logout',  //pathは適宜調整
            'redirect_uri'  => $parameters['appUrl'] .'/sso/cognito/callback',     //pathは適宜調整
            'response_type' => 'code',
            'state'         => $parameters['state'],
            'scope'         => 'aws.cognito.signin.user.admin+email+openid+phone+profile',
        ]);
    }
}
