# Use the official PHP image with Apache
FROM php:8.3-apache

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql gd

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set build-time arguments for GitHub credentials
ARG GITHUB_TOKEN

# Clone the private Laravel repository using the token
RUN git clone https://$GITHUB_TOKEN@github.com/Housing-Records/laravel.git /var/www/html

# Change ownership of our applications
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Install Composer dependencies
RUN composer install

# Copy environment file
COPY .env.example .env

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
