FROM php:apache

RUN apt-get update \
    && apt-get install libldap2-dev \
    && docker-php-ext-install ldap

RUN a2enmod rewrite
COPY php.ini /usr/local/etc/php/

WORKDIR /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
