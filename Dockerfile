#Pull image file
FROM ubuntu:18.04

#Install nginx
RUN \
#  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx php-fpm php-mysql && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

#Define mountable directory
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

COPY example.com /etc/nginx/sites-enabled/

#Define working directory
WORKDIR /etc/nginx
COPY ["start.sh", "/root/start.sh"]
WORKDIR /root
RUN chmod +x start.sh
CMD ["./start.sh"]

#Expose ports
EXPOSE 80 443
