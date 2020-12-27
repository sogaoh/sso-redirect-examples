.PHONY:

help:
	cat Makefile

# nginx-node


# laravel
vendor: composer.json composer.lock
	composer self-update
	composer validate
	composer install
dump:
	composer dump-autoload
clear:
	composer clear-cache
	php artisan view:clear
	php artisan route:clear
	php artisan cache:clear
	php artisan clear-compiled
	php artisan config:cache
clr: clear dump

test: vendor
	vendor/bin/phpunit --configuration=phpunit.xml
#dusk:
#	php artisan dusk

# one time
key:
	php artisan key:generate
	@make clr
link:
	php artisan storage:link
dev-tools:
	composer require doctrine/dbal "^2"
	composer require --dev barryvdh/laravel-ide-helper
	composer require --dev beyondcode/laravel-dump-server
	composer require --dev barryvdh/laravel-debugbar
	composer require --dev roave/security-advisories:dev-master
	php artisan vendor:publish --provider="BeyondCode\DumpServer\DumpServerServiceProvider"
	php artisan vendor:publish --provider="Barryvdh\Debugbar\ServiceProvider"
#dusk-init:
#	composer require --dev laravel/dusk
#	php artisan dusk:install
