#!/usr/bin/env bash

echo "<VirtualHost *:80>" > /etc/apache2/sites-available/000-default.conf \
&& echo "        ServerAdmin \${SERVER_ADMIN}" >> /etc/apache2/sites-available/000-default.conf \
&& echo "        DocumentRoot \${DOCUMENT_ROOT}" >> /etc/apache2/sites-available/000-default.conf \
&& echo "        LogLevel \${LOG_LEVEL}" >> /etc/apache2/sites-available/000-default.conf \
&& echo "        ErrorLog \${APACHE_LOG_DIR}/error.log" >> /etc/apache2/sites-available/000-default.conf \
&& echo "        CustomLog \${APACHE_LOG_DIR}/access.log combined" >> /etc/apache2/sites-available/000-default.conf \
&& echo "</VirtualHost>" >> /etc/apache2/sites-available/000-default.conf


exec "$@"
