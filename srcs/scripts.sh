openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj "/C=RU/ST=Kazan/L=Kazan/O=21/OU=tbarth/CN=localhost"

service nginx start
service mysql start

mysql -u root --skip-password -e "create database Ex_DB;"
mysql -u root --skip-password -e "create user 'admin'@'localhost' identified by 'pass';" 
mysql -u root --skip-password -e "GRANT ALL PRIVILEGES ON Ex_DB.* to 'admin'@'localhost';" 
mysql -u root --skip-password -e "FLUSH PRIVILEGES;"

service php7.3-fpm start

bash
