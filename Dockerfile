FROM php:5-apache

RUN apt-get update \
    && apt-get install -y libldb-dev libldap2-dev \
    && ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \
    && ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so\
    && docker-php-ext-install ldap json
    
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
