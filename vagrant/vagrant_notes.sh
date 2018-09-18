# latest vagrant is at https://www.vagrantup.com/downloads.html

# install vagrant on ubuntu
sudo apt-get install vagrant

# install libvirt on ubuntu
sudo apt-get install libvirt-bin libvirt-doc python-virtinst

# create Vagrantfile with
sudo vagrant init centos/7
# or manually with this content:
Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
end

# use libvirt with vagrant
# or export VAGRANT_DEFAULT_PROVIDER=libvirt
sudo vagrant up --provider=libvirt

# accss vm
sudo vagrant ssh

# destroy vm
sudo vagrant destroy -f
