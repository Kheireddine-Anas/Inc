FROM portainer/portainer-ce:2.19.4

# Expose Portainer UI and API ports
EXPOSE 9000 9443

# Set data volume
VOLUME /data
# COPY password /tmp/password
# Start Portainer
CMD ["--no-analytics"]
# CMD ["--admin-password-file", "/tmp/password", "--no-analytics"]