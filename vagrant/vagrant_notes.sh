# latest vagrant is at https://www.vagrantup.com/downloads.html

# install vagrant on ubuntu
sudo apt-get install vagrant

# install libvirt on ubuntu
sudo apt-get install libvirt-bin libvirt-doc python-virtinst

# use libvirt with vagrant
# or export VAGRANT_DEFAULT_PROVIDER=libvirt
sudo vagrant up --provider=libvirt

# accss vm
sudo vagrant ssh

# destroy vm
sudo vagrant destroy -f
