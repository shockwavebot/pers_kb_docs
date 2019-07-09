# Install Docker
sudo zypper in -y docker # SUSE
sudo apt-get install docker.io # ubuntu 18

###################################
# CONTAINERS
# List containers (running/all)
sudo docker ps -a
# Delete container
sudo docker rm _id_

###################################
# IMAGES
# List downloaded images
sudo docker images
# download or update image
docker pull img_name
# Delete images
sudo docker image rm _name_
# get image details 
sudo docker image inspect img_name

# check version 
docker inspect cont_name | grep -i version 


