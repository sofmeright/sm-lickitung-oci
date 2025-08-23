# syntax=docker/dockerfile:1.7
FROM alpine:3.22

# Install nginx
RUN apk add --no-cache nginx ca-certificates tzdata

# Create paths nginx expects
RUN mkdir -p /var/cache/nginx /var/run/nginx /etc/nginx/conf.d

# Copy nginx configs
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy your static site into the web root
COPY www-data/ /usr/share/nginx/html/

# (Optional) set sensible perms
RUN chown -R nginx:nginx /usr/share/nginx/html /var/cache/nginx /var/run/nginx

EXPOSE 80
STOPSIGNAL SIGQUIT
CMD ["nginx", "-g", "daemon off;"]
