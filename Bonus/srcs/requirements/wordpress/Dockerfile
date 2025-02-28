FROM debian:bullseye

# Add Sury PHP repository
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    lsb-release \
    software-properties-common

RUN curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

# Install PHP 8.1 and required extensions
RUN apt-get update && apt-get install -y \
    mariadb-client \
    php8.1 \
    php8.1-fpm \
    php8.1-mysql \
    php8.1-redis \
    redis-tools \
    php8.1-curl \
    php8.1-dom \
    php8.1-exif \
    php8.1-fileinfo \
    php8.1-mbstring \
    php8.1-xml \
    php8.1-zip \
    iputils-ping \
    curl \
    unzip \
    && mkdir -p /run/php \
    && chown www-data:www-data /run/php \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

COPY ./conf/wp-install.sh /usr/local/bin/wp-install.sh
RUN chmod +x /usr/local/bin/wp-install.sh

EXPOSE 9000

CMD ["/usr/local/bin/wp-install.sh"]