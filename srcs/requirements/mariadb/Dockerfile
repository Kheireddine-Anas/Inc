FROM debian:bullseye

# Arguments for database configuration
ARG DB_NAME
ARG DB_USER
ARG DB_PASS

# Install MariaDB and required dependencies
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Create necessary directories and set permissions
RUN mkdir -p /var/run/mysqld && \
    chown mysql:mysql /var/run/mysqld && \
    chmod 755 /var/run/mysqld

RUN sed -i "s|socket = /run/mysqld/mysqld.sock|socket = 0.0.0.0|g" /etc/mysql/mariadb.cnf
RUN sed -i "s|bind-address            = 127.0.0.1|bind-address            = 0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

# Initialize the database
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Expose the MariaDB port
EXPOSE 3306

# Copy and execute the database setup script
COPY ./conf/run_db.sh /run_db.sh
RUN chmod +x /run_db.sh

# Run as the mysql user
# USER mysql


ENTRYPOINT ["/bin/bash", "-c", "/run_db.sh && mariadbd --skip-log-error"]
