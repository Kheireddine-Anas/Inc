#!/bin/sh

# Initialize the database if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    chown -R mysql:mysql /var/lib/mysql
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm

    tfile=$(mktemp)
    if [ ! -f "$tfile" ]; then
        return 1
    fi
fi

echo $DB_ROOT
echo $DB_NAME
echo $DB_USER
echo $DB_PASS


# Configure the root user and create the database
if [ ! -d "/var/lib/mysql/wordpress" ]; then
    cat <<EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
DROP DATABASE IF EXISTS wordpress;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='wordpress';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '';
CREATE DATABASE wordpress CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}' WITH GRANT OPTION;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT}';
EOF

    # Run the SQL commands
   mariadbd --user=mysql --bootstrap < /tmp/create_db.sql
    rm -f /tmp/create_db.sql
fi
