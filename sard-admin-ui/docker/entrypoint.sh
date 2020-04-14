#!/bin/sh

cat > /etc/nginx/conf.d/default.conf <<EOF
server {

  listen 80;

  location /auth/ {
    proxy_pass http://${SARD_ADMIN_SERVICE_HOST}:${SARD_ADMIN_SERVICE_PORT}/auth/ ;
  }

  location /user/ {
    proxy_pass http://${SARD_ADMIN_SERVICE_HOST}:${SARD_ADMIN_SERVICE_PORT}/user/ ;
  }

  location /group/ {
    proxy_pass http://${SARD_ADMIN_SERVICE_HOST}:${SARD_ADMIN_SERVICE_PORT}/group/ ;
  }

  location /jobs/ {
    proxy_pass http://${SARD_ADMIN_SERVICE_HOST}:${SARD_ADMIN_SERVICE_PORT}/jobs/ ;
  }

  location / {
    root   /usr/share/nginx/html;
  }

  error_page 403 404 /empty;

  location = /empty {
    internal;
    return 200 "";
  }

}
EOF

exec "$@"