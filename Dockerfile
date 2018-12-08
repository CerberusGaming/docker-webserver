FROM php:7-apache

ENV SERVER_ADMIN webmaster@localhost
ENV DOCUMENT_ROOT /var/www/html
ENV LOG_LEVEL "info ssl:warn"

RUN apt-get update \
    && apt-get -y install libldap2-dev zlib1g-dev libxml2-dev libmcrypt-dev \
    && printf "\n" | pecl install -o -f redis mcrypt-1.0.1 \
    && docker-php-ext-install ldap zip xmlrpc bcmath mysqli \
    && docker-php-ext-enable mcrypt redis

RUN apt-get -y purge libldap2-dev zlib1g-dev libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite
COPY php.ini /usr/local/etc/php/


WORKDIR ${DOCUMENT_ROOT}

EXPOSE 80
CMD ["apache2-foreground"]
