FROM nginx:1.25
ADD https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 /bin/confd
RUN chmod +x /bin/confd

COPY confd /etc/confd
COPY nginx/nginx.conf /etc/nginx/nginx.conf

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]


