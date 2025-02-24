FROM debian:bullseye

RUN apt-get update && apt-get install -y redis-server

RUN mkdir -p /etc/redis && \
    echo "bind 0.0.0.0" >> /etc/redis/redis.conf


CMD ["redis-server", "--protected-mode", "no"]