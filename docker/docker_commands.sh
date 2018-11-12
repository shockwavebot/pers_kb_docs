# Install Docker
sudo zypper in -y docker # SUSE
sudo apt-get install docker.io # ubuntu 18

# List downloaded images
sudo docker images

# List containers (running/all)
sudo docker ps -a

# Delete container
sudo docker rm _id_

# Delete images
sudo docker image rm _name_
