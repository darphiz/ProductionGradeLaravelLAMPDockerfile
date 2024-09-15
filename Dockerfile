FROM chialab/php:8.3-apache

# Set environment variable for Apache DocumentRoot
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public

# change to match your domain
ENV APACHE_SERVER_NAME=localhost 

# Copy PHP ini configuration
COPY php.ini /usr/local/etc/php/php.ini

# Enable Apache modules for URL rewriting, headers, and remoteip
RUN a2enmod rewrite headers \
    && sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# copy apache configuration
COPY apache2.conf /etc/apache2/sites-available/000-default.conf

# Set the working directory
WORKDIR /var/www/html

# Copy the application code
COPY hello-laravel /var/www/html

# Install project dependencies
RUN composer install --optimize-autoloader

# Copy the entrypoint script and make it executable
COPY scripts/entrypoint.sh /var/www/html/entrypoint.sh
RUN chmod +x /var/www/html/entrypoint.sh

# Set the correct permissions for Laravel
RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/html/storage \
    && chmod -R 775 /var/www/html/bootstrap/cache \
    && touch /var/www/html/storage/logs/laravel.log \
    && chown www-data:www-data /var/www/html/storage/logs/laravel.log \
    && chmod 775 /var/www/html/storage/logs/laravel.log

ENTRYPOINT ["/var/www/html/entrypoint.sh"]
EXPOSE 80

# Command to start Apache in foreground
CMD ["apache2-foreground"]