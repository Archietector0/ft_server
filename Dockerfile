# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tbarth <marvin@42.fr>                      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/07 21:49:13 by tbarth            #+#    #+#              #
#    Updated: 2021/02/07 21:54:43 by tbarth           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y	\
	nginx				\
	vim					\
	openssl				\
	wget				\
	default-mysql-server\
	php7.3-mysql		\
	php7.3-fpm

COPY srcs/default /etc/nginx/sites-available

#Установка WordPress

WORKDIR /var/www/html
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz					
RUN rm -rf latest.tar.gz
COPY srcs/wp-config.php /var/www/html/wordpress 	

#Установка PHPMyAdmin

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
RUN tar -xzvf phpMyAdmin-5.0.4-all-languages.tar.gz
RUN mv phpMyAdmin-5.0.4-all-languages phpmyadmin
RUN rm -rf phpMyAdmin-5.0.4-all-languages.tar.gz

RUN chmod -R 755 .
RUN chown -R www-data:www-data .

WORKDIR /
COPY srcs/scripts.sh .

CMD bash scripts.sh
