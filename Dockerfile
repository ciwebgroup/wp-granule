# Use the official WordPress image as the base image
FROM wordpress:latest

# Install Xdebug if not already installed
RUN if ! php -m | grep -q 'xdebug'; then \
    pecl install xdebug && docker-php-ext-enable xdebug; \
    fi

# Copy custom php.ini configuration
COPY php.ini /usr/local/etc/php/conf.d/php-overrides.ini

# Copy info.php to the web root
COPY info.php /var/www/html/info.php
