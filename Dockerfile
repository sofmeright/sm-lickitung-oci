# syntax=docker/dockerfile:1.7
FROM alpine:3.23

# Install nginx
RUN apk add --no-cache nginx ca-certificates tzdata

# Create paths nginx expects
RUN mkdir -p /var/cache/nginx /etc/nginx/conf.d /etc/nginx/templates

# Copy nginx configs
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf.template /etc/nginx/templates/default.conf.template

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy your static site into the web root
COPY www-data/ /usr/share/nginx/html/

# Set ownership for non-root operation
RUN chown -R nginx:nginx /usr/share/nginx/html /var/cache/nginx /etc/nginx/conf.d

ENV LISTEN_PORT=8080

EXPOSE 8080
USER nginx
STOPSIGNAL SIGQUIT
ENTRYPOINT ["/entrypoint.sh"]
