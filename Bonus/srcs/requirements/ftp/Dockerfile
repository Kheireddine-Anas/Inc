FROM debian:bullseye

RUN apt-get update && apt-get install -y vsftpd && \
    mkdir -p /var/run/vsftpd/empty

ARG FTP_USER
ARG FTP_PASS
RUN useradd -m -d /var/www/html ${FTP_USER} && \
    echo "${FTP_USER}:${FTP_PASS}" | chpasswd && \
    chown ${FTP_USER}:${FTP_USER} /var/www/html

COPY ./conf/vsftpd.conf /etc/vsftpd.conf

EXPOSE 20 21 30000-30009

CMD ["vsftpd", "/etc/vsftpd.conf"]