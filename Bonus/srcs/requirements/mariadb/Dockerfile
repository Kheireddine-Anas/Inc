FROM debian:bullseye

ARG DB_NAME
ARG DB_USER
ARG DB_PASS

RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld && \
    chown mysql:mysql /var/run/mysqld && \
    chmod 755 /var/run/mysqld

RUN sed -i "s|/run/mysqld/mysqld.sock|/var/run/mysqld/mysqld.sock|g" /etc/mysql/mariadb.conf.d/50-server.cnf
RUN sed -i "s|bind-address            = 127.0.0.1|bind-address            = 0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

# Initialize the database
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

COPY ./conf/run_db.sh /run_db.sh
RUN chmod +x /run_db.sh


ENTRYPOINT ["/bin/bash", "-c", "/run_db.sh && mariadbd --skip-log-error"]
