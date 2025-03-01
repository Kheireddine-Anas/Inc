FROM nginx:1.24-alpine

# Copy Nginx configuration
COPY ./conf/static.conf /etc/nginx/conf.d/default.conf

# Copy static files
COPY ./public /usr/share/nginx/html

# Ensure proper permissions
RUN chmod -R 755 /usr/share/nginx/html