# setup wordpress instance with docker
mkdir ~/wordpress && cd ~/wordpress
# mariadb container
sudo docker run -e MYSQL_ROOT_PASSWORD=mysqlpass321 -e MYSQL_DATABASE=wordpress --name wordpressdb -v "$PWD/database":/var/lib/mysql -d mariadb:latest
# get wp image
sudo docker pull wordpress
sudo docker run -e WORDPRESS_DB_PASSWORD=mysqlpass321 --name wordpress --link wordpressdb:mysql -p 80:80 -v "$PWD/html":/var/www/html -d wordpress
