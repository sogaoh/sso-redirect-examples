<?php

namespace App\Libs\Sso\Trait;

use Illuminate\Support\Str;

/**
 * Trait SsoRequestHelper
 * @package App\Lib\Sso
 */
trait SsoRequestHelper
{
    /**
     * state 用に UUID（バージョン４）を取得する
     * @return string
     */
    public function getStateUuid(): string
    {
        return (string) Str::uuid();
    }
}
