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

RUN echo "<VirtualHost *:80>" > /etc/apache2/sites-available/000-default.conf \
    && echo "        ServerAdmin ${SERVER_ADMIN}" >> /etc/apache2/sites-available/000-default.conf \
    && echo "        DocumentRoot ${DOCUMENT_ROOT}" >> /etc/apache2/sites-available/000-default.conf \
    && echo "        LogLevel ${LOG_LEVEL}" >> /etc/apache2/sites-available/000-default.conf \
    && echo "        ErrorLog ${APACHE_LOG_DIR}/error.log" >> /etc/apache2/sites-available/000-default.conf \
    && echo "        CustomLog ${APACHE_LOG_DIR}/access.log combined" >> /etc/apache2/sites-available/000-default.conf \
    && echo "</VirtualHost>" >> /etc/apache2/sites-available/000-default.conf

WORKDIR ${DOCUMENT_ROOT}

EXPOSE 80
CMD ["apache2-foreground"]
