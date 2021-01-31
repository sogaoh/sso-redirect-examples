<?php

namespace App\Libs\Sso;

use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Contracts\Auth\Guard;
use Illuminate\Http\Request;

/**
 * Class CognitoSessionGuard
 * @package App\Libs\Sso
 */
class CognitoSessionGuard implements Guard
{
    /** @var string SESSION_KEY */
    const SESSION_KEY = 'Cognito';

    /**
     * The currently authenticated user.
     *
     * @var \Illuminate\Contracts\Auth\Authenticatable|null
     */
    protected Authenticatable|null $user;

    /** @var Request  */
    protected Request $request;

    /**
     * CognitoSessionGuard constructor.
     * @param Request $request
     */
    public function __construct(Request $request)
    {
        $this->user = null;
        $this->request = $request;
    }

    /**
     * Determine if the current user is authenticated.
     *
     * @return bool
     */
    public function check()
    {
        return !\is_null($this->user());
    }

    /**
     * Determine if the current user is a guest.
     *
     * @return bool
     */
    public function guest()
    {
        return !$this->check();
    }

    /**
     * Get the currently authenticated user.
     *
     * @return \Illuminate\Contracts\Auth\Authenticatable|null
     */
    public function user()
    {
        return $this->user ?: $this->getSessionUser();
    }

    /**
     * Get the ID for the currently authenticated user.
     *
     * @return int|string|null
     */
    public function id()
    {
        $user = $this->user();
        return $user->id ?? null;
    }

    /**
     * Validate a user's credentials.
     *
     * @param  array  $credentials
     * @return bool
     */
    public function validate(array $credentials = [])
    {
        // No validate.
        return true;
    }

    /**
     * Set the current user.
     *
     * @param Authenticatable|null $user
     * @return void
     */
    public function setUser(?Authenticatable $user)
    {
        $this->user = $user;
        $this->request->session()->put(self::SESSION_KEY, $user);
    }

    /**
     * get session user.
     * @return mixed
     */
    private function getSessionUser()
    {
        return $this->request->session()->get(self::SESSION_KEY);
    }

    /**
     * logout of CognitoSessionGuard <br>
     * (call from App\Http\Controllers\Sso\CognitoController # logout)
     */
    public function logout(): void
    {
        if (!\is_null($this->user())) {
            $this->setUser(null);
            $this->request->session()->forget(self::SESSION_KEY);
        }
    }
}
