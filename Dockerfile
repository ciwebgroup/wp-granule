# Use the official WordPress image as the base image
FROM wordpress:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    wget \
    default-mysql-client \
    && docker-php-ext-install zip

# Install Xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install OpenTelemetry MySQL Instrumentation
WORKDIR /var/www/html
RUN composer require open-telemetry/opentelemetry
WORKDIR /

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Install OpenTelemetry
RUN pecl install opentelemetry-1.1.0 \
    && docker-php-ext-enable opentelemetry

# Download and extract WordPress
RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz --strip-components=1 -C /var/www/html \
    && rm latest.tar.gz

# Copy info.php to the web root
COPY info.php /var/www/html/info.php

# Change ownership of the web root to www-data
RUN chown -R www-data:www-data /var/www/html

# Switch to www-data user
USER www-data
