FROM quay.io/app-sre/fluentd-upstream:v1.16-1

USER root

RUN apk update && apk upgrade busybox busybox-binsh libcrypto3 libssl3 \
    ncurses-libs ncurses-terminfo-base ssl_client \
    && apk add --no-cache --update --virtual .build-deps build-base ruby-dev \
    && echo 'gem: --no-document' >> /etc/gemrc \
    && gem install fluent-plugin-s3 \
    && gem install fluent-plugin-slack \
    && gem install fluent-plugin-cloudwatch-logs \
    && gem install fluent-plugin-teams \
    && gem install fluent-plugin-rewrite-tag-filter \
    && gem install nokogiri \
    && apk del .build-deps \
    && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

USER fluent
