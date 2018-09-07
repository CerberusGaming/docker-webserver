FROM php:apache

RUN apt-get update \
    && apt-get install libldap2-dev \
    && docker-php-ext-install ldap
    
# do some php / apache settings in here somewhere

WORKDIR /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
