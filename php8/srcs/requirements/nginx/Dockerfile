FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl

# Generate SSL certificates
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/akheired.42.fr.key \
    -out /etc/nginx/ssl/akheired.42.fr.crt \
    -subj "/C=MA/ST=Tetouan/L=Martil/O=1337/OU=MED/CN=akheired.42.fr"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
