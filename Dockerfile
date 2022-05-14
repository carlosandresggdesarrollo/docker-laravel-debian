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



RUN apt  install wget -y
RUN apt install -y curl unzip

#Installation of PHP 8
RUN  apt -y install lsb-release apt-transport-https ca-certificates 
RUN  wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg 
RUN  echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" |  tee /etc/apt/sources.list.d/php.list
RUN apt-get update 
RUN  apt install php7.4 -y
RUN  apt install php7.4-cli -y
 RUN  apt install -y php7.4-bcmath php7.4-xml \ 
              php7.4-mysql  php7.4-zip  php7.4-intl \
              php7.4-ldap  php7.4-gd  php7.4-cli \ 
              php7.4-bz2  php7.4-curl  php7.4-mbstring \
              php7.4-pgsql php7.4-opcache php7.4-soap  php7.4-cgi       

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
