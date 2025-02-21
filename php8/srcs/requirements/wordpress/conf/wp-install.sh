#!/bin/bash

while ! mariadb -hmariadb -u$DB_USER -p$DB_PASS $DB_NAME --silent 2> /dev/null; do
    sleep 1;
done

# Check if WordPress is already configured
if [ -f /var/www/html/wp-config.php ]
then
    echo "Wordpress already downloaded"
else
    echo "Downloading WordPress"
    # Download WordPress
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

    sed -i 's#listen = /run/php/php8.1-fpm.sock#listen = 0.0.0.0:9000#' /etc/php/8.1/fpm/pool.d/www.conf
    sed -i 's#pid = /run/php/php8.1-fpm.pid#pid = 0.0.0.0:9000#' /etc/php/8.1/fpm/php-fpm.conf

    cd /var/www/html 
    wp core download --allow-root
    mv wp-config-sample.php wp-config.php

    wp config set DB_NAME $DB_NAME --allow-root
    wp config set DB_USER $DB_USER --allow-root
    wp config set DB_PASSWORD $DB_PASS --allow-root
    wp config set DB_HOST 'mariadb:3306' --allow-root

    # Install WordPress
    wp core install --url=$DOMAIN_NAME --title=$TITLE \
    --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS \
    --admin_email=$WP_ADMIN_EMAIL --allow-root

    # Add dynamic URL configuration to wp-config.php
    echo "Adding dynamic URL configuration to wp-config.php"
    echo "define('WP_HOME', 'https://' . \$_SERVER['HTTP_HOST']);" >> /var/www/html/wp-config.php
    echo "define('WP_SITEURL', 'https://' . \$_SERVER['HTTP_HOST']);" >> /var/www/html/wp-config.php
    echo "define('WP_REDIS_HOST', 'redis');" >> /var/www/html/wp-config.php
    echo "define('WP_REDIS_PORT', 6379);" >> /var/www/html/wp-config.php

    # Update siteurl and home to use the VM's IP address
    wp option update siteurl "https://localhost" --allow-root
    wp option update home "https://localhost" --allow-root

    # Create additional users
    wp user create $WP_USER1 $WP_EMAIL1 --role=author --user_pass=$WP_PASS1 --allow-root
    wp user create $WP_USER2 $WP_EMAIL2 --role=author --user_pass=$WP_PASS2 --allow-root

    # Set permissions
    chown -R www-data:www-data /var/www/html/
fi

# Ensure the /run/php directory exists
mkdir -p /run/php

# Start PHP-FPM
exec php-fpm8.1 -F
