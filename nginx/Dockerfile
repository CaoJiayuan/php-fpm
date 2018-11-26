FROM cjy632258/php-fpm-slim:latest

RUN apk add --update --no-cache nginx gettext

COPY nginx-run.sh /nginx-run.sh
RUN chmod +x /nginx-run.sh && \
    #default nginx pid directory
    mkdir -p /run/nginx


EXPOSE 9000 80 443
ENTRYPOINT /nginx-run.sh