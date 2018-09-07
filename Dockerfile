FROM php:7.1-apache-jessie

RUN apt-get update \
    && apt-get install libldap2-dev \
    && docker-php-ext-install ldap
    
RUN docker-php-ext-install mysqli
    
RUN printf "\n" | pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis

RUN apt-get -y purge libldap2-dev \
    && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite
COPY php.ini /usr/local/etc/php/

WORKDIR /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
