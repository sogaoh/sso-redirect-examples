<?php

namespace App\Libs\Sso;

use GuzzleHttp\Client as Guzzle;
//use Illuminate\Http\JsonResponse;
use Psr\Http\Message\ResponseInterface;

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

    /** @var Guzzle GuzzleHttp\Client */
    private Guzzle $guzzle;

    /**
     * CognitoAuthRequest constructor.
     * @param Guzzle|null $guzzle
     */
    public function __construct(
        Guzzle $guzzle = null
    )
    {
        $this->config = config('sso-cognito');
        $this->domain = 'https://' . $this->config['domain_prefix'] .
            '.auth.' . $this->config['region'] . '.amazoncognito.com/';
        $this->guzzle = $client ?? new Guzzle([
                'base_uri' => $this->domain,
                'timeout'  => 0   //RequestOptions::TIMEOUT - second
            ]);
    }

    /**
     * @param array $parameters
     * @return string
     */
    public function buildLoginRequest(array $parameters): string
    {
        return $this->domain . 'login?' .
            \http_build_query([
                'client_id'     => $this->config['app_client_id'],
                'redirect_uri'  => $parameters['appUrl'] .'/sso/cognito/callback',     //pathは適宜調整
                'response_type' => 'code',
                'state'         => $parameters['state'],
                'scope'         => 'aws.cognito.signin.user.admin+email+openid+phone+profile'
            ]);
    }

    /**
     * @param array $parameters
     * @return ResponseInterface
     */
    public function invokeTokenRequest(array $parameters): ResponseInterface
    {
        return $this->guzzle->request('POST', 'oauth2/token', [
            'form_params' => [      //<- 'application/x-www-form-urlencoded'
                'grant_type'    => 'authorization_code',
                'client_id'     => $this->config['app_client_id'],
                'client_secret' => $this->config['app_client_secret'],
                'redirect_uri'  => $parameters['appUrl'] .'/sso/cognito/callback',     //pathは適宜調整
                'code'          => $parameters['loginResult']['code'],
            ],
        ]);
    }

    /**
     * @param array $parameters
     * @return ResponseInterface
     */
    public function invokeUserInfoRequest(array $parameters): ResponseInterface
    {
        return $this->guzzle->request('GET', 'oauth2/userInfo', [
            'headers' => $parameters['headers']
        ]);
    }
}
