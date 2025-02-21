FROM debian:bullseye

RUN apt-get update && apt-get install -y redis

# Disable THP and set overcommit_memory
RUN echo madvise > /sys/kernel/mm/transparent_hugepage/enabled && \
    echo 1 > /proc/sys/vm/overcommit_memory

COPY ./conf/redis.conf /etc/redis/redis.conf

CMD ["redis-server", "/etc/redis/redis.conf"]