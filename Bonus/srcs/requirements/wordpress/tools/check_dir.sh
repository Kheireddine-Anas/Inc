#!/bin/bash

# Directories to create
MARIADB_DIR="/home/akheired/data/mariadb"
WORDPRESS_DIR="/home/akheired/data/wordpress"

# Delete directories if they exist
if [ -d "$MARIADB_DIR" ]; then
    echo "Deleting existing MariaDB directory..."
    rm -rf "$MARIADB_DIR"
fi

if [ -d "$WORDPRESS_DIR" ]; then
    echo "Deleting existing WordPress directory..."
    rm -rf "$WORDPRESS_DIR"
fi

# Create directories
echo "Creating directories..."
mkdir -p "$MARIADB_DIR"
mkdir -p "$WORDPRESS_DIR"

# Set permissions
echo "Setting permissions..."
sudo chown -R $USER:$USER "$MARIADB_DIR"
sudo chown -R $USER:$USER "$WORDPRESS_DIR"
sudo chmod -R 755 "$MARIADB_DIR"
sudo chmod -R 755 "$WORDPRESS_DIR"

echo "Setup complete for directories."
