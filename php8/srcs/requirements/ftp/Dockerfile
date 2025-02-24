FROM debian:bullseye

# Install vsftpd and create FTP user
RUN apt-get update && apt-get install -y vsftpd && \
    mkdir -p /var/run/vsftpd/empty

# Create FTP user and set password
ARG FTP_USER
ARG FTP_PASS
RUN useradd -m -d /var/www/html ${FTP_USER} && \
    echo "${FTP_USER}:${FTP_PASS}" | chpasswd && \
    chown ${FTP_USER}:${FTP_USER} /var/www/html

# Copy configuration
COPY ./conf/vsftpd.conf /etc/vsftpd.conf

# Expose FTP ports
EXPOSE 20 21 30000-30009

CMD ["vsftpd", "/etc/vsftpd.conf"]