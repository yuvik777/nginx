#!/bin/bash

set -eu

echo "update Nginx config"
envsubst '\${HOST1} \${HOST2} \${HOST3} \${PORT}' < /usr/share/nginx/html/config/default.conf > /etc/nginx/nginx.conf

exec "$@"