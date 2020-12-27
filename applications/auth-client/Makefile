.PHONY:

help:
	cat Makefile

# one time
key:
	php artisan key:generate
link:
	php artisan storage:link

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
#e2e:
#	php artisan dusk
