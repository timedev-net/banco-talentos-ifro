#!/bin/bash

set -m

php-fpm -D &
nginx -g "daemon off;"

fg %1