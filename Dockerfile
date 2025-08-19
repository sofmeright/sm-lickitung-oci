# syntax=docker/dockerfile:1.7
FROM alpine:3.22

RUN apk add --no-cache nginx ca-certificates tzdata \
 && mkdir -p /var/cache/nginx /var/run/nginx /etc/nginx/conf.d

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# Put your app here
COPY www-data/ /usr/share/nginx/html/

RUN chown -R nginx:nginx /usr/share/nginx/html /var/cache/nginx /var/run/nginx

EXPOSE 80
STOPSIGNAL SIGQUIT
CMD ["nginx", "-g", "daemon off;"]