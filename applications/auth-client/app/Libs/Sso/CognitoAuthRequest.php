<?php

namespace App\Libs\Sso;

use GuzzleHttp\Client as Guzzle;
//use Illuminate\Http\JsonResponse;
//use Psr\Http\Message\ResponseInterface;

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
     * @param array $configs
     * @return string
     */
    public function buildLoginRequest(array $configs): string
    {
        return $this->domain . 'login?' .
            \http_build_query([
                'client_id'     => $this->config['app_client_id'],
                'redirect_uri'  => $configs['appUrl'] .'/sso/cognito/callback',     //pathは適宜調整
                'response_type' => 'code',
                'state'         => $configs['state'],
                'scope'         => 'aws.cognito.signin.user.admin+email+openid+phone+profile'
            ]);
    }
}
