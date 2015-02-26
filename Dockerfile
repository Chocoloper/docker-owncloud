FROM ubuntu:14.04
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q && apt-get install -yq mysql-server-5.6 php5 php5-cgi php5-common php5-gd php5-cli php5-fpm php-apc php5-mysql openssl nginx wget

RUN wget https://download.owncloud.org/community/owncloud-8.0.0.tar.bz2 \
	&& mkdir /var/www \
	&& tar -xvf owncloud-8.0.0.tar.bz2 -C /var/www/ \
	&& chown www-data:www-data -R /var/www/owncloud \
	&& rm owncloud-8.0.0.tar.bz2

ADD src/main/files/owncloud.sites	/etc/nginx/sites-enabled/owncloud.sites
ADD src/main/files/nginx.conf		/etc/nginx/
RUN rm -f				/etc/nginx/sites-enabled/default
ADD src/main/files/owncloud.sh		/opt/owncloud.sh
RUN chmod +x				/opt/owncloud.sh
ADD src/main/files/php5-fpm.www.conf	/etc/php5/fpm/pool.d/www.conf
# copy pre-existing certificate
RUN openssl req -new -newkey rsa:4096 -x509 -days 365 -nodes -subj "/C=DE/ST=NRW/L=Aachen/O=RWTH Aachen/O=i5/CN=Layers Box" -out /opt/server.pem -keyout /opt/server.key 



# default command
CMD sh /opt/owncloud.sh

# exposed ports
EXPOSE 80 443
EXPOSE 3306
