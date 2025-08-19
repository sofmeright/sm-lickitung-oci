# syntax=docker/dockerfile:1.7
FROM alpine:3.22

RUN apk add --no-cache nginx ca-certificates tzdata \
 && mkdir -p /var/cache/nginx /var/run/nginx /etc/nginx/http.d

# Our top-level nginx.conf: includes mime.types and http.d
COPY nginx.conf /etc/nginx/nginx.conf

# Our vhost
COPY 00-app.conf /etc/nginx/http.d/00-app.conf

# Your app files (or bind mount at runtime)
COPY www-data/ /usr/share/nginx/html/

EXPOSE 80
STOPSIGNAL SIGQUIT
CMD ["nginx", "-g", "daemon off;"]