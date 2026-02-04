#!/bin/sh
set -e

# Substitute environment variables into nginx config template
envsubst '${LISTEN_PORT}' < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf

exec nginx -g 'daemon off;'
