# Docker notes 

## Install docker on Ubuntu 18

`sudo apt-get install docker.io`

### Setup WordPress with docker

`sudo docker pull wordpress`

`sudo docker pull mariadb`

`sudo docker images`

`mkdir ~/wordpress && cd ~/wordpress`

`sudo docker run -e MYSQL_ROOT_PASSWORD=mdbpass123 -e MYSQL_DATABASE=wordpress --name wordpressdb -v "$PWD/database":/var/lib/mysql -d mariadb:latest`

`sudo docker run -e WORDPRESS_DB_PASSWORD=mdbpass123 --name wordpress --link wordpressdb:mysql -p 127.0.0.1:80:80 -v "$PWD/html":/var/www/html -d wordpress`

To start with custom env variable: `--env MY_VAR=somevalue`



