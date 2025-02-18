FROM debian:bullseye

# Install required packages
RUN apt-get update && apt-get install -y \
    mariadb-client\
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-dom \
    php7.4-exif \
    php7.4-fileinfo \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-zip \
    curl \
    unzip \
    && mkdir -p /run/php \
    && chown www-data:www-data /run/php \
    && rm -rf /var/lib/apt/lists/*s-med

# Set the working directory
WORKDIR /var/www/html

# Copy the WordPress configuration script
COPY ./conf/wp-install.sh /usr/local/bin/wp-install.sh
RUN chmod +x /usr/local/bin/wp-install.sh

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Set the entrypoint to the script
CMD ["/usr/local/bin/wp-install.sh"]
