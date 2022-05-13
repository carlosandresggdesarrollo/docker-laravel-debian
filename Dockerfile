FROM debian:9
LABEL Autor="Carlos Andres González Gómez"

# Update of sistem and repositories.
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get clean 

#Installation of Apache 2 
RUN apt-get install apache2  -y 
RUN /etc/init.d/apache2 restart

#Installation of PHP 8
RUN apt-get install ca-certificates apt-transport-https software-properties-common wget curl lsb-release -y
RUN curl -sSL https://packages.sury.org/php/README.txt |  bash -x && \
          apt-get update && \
          apt-get -y upgrade && \
          apt install php8.1 libapache2-mod-php8.1 -y 
RUN apt install php8.1-fpm libapache2-mod-fcgid \
          && apt install -y php8.1-bcmath php8.1-xml \ 
              php8.1-mysql  php8.1-zip  php8.1-intl \
              php8.1-ldap  php8.1-gd  php8.1-cli \ 
              php8.1-bz2  php8.1-curl  php8.1-mbstring \
              php8.1-pgsql php8.1-opcache php8.1-soap  php8.1-cgi 
       

RUN /etc/init.d/apache2 restart
RUN chmod -R 777 /var/www/html


# Installation of Compose
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN composer --version


# Installation of Node 15 lts and yarm
RUN cd ~
RUN curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get update
RUN apt-get install nodejs -y && nodejs -v
RUN apt-get install yarn -y


# tool 
RUN apt-get install nano

#Puertos
EXPOSE 80
EXPOSE 443

#
# Define default command.
CMD ["tail -f /dev/null"]
