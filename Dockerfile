FROM ubuntu:20.04

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y curl tini php7.2 php7.2-dom php7.2-xsl php7.2-mbstring && \
    update-alternatives --set php /usr/bin/php7.2 && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN curl -sLo /usr/local/bin/phpdox http://phpdox.de/releases/phpdox.phar && chmod +x /usr/local/bin/phpdox

COPY phpdox-entrypoint.sh /usr/local/bin/phpdox-entrypoint.sh

WORKDIR /app

ENTRYPOINT ["phpdox-entrypoint.sh"]

CMD ["phpdox"]
