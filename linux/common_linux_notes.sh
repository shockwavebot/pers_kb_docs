# how to check system memory, how much RAM memory is on the server?
cat /proc/meminfo |grep MemTotal

# not asking for ssh adding new host
sudo sed -i "/StrictHostKeyChecking/c\StrictHostKeyChecking no" /etc/ssh/ssh_config

# disable dhcp to set change host name
sed -i '/^DHCLIENT_SET_HOSTNAME/c\DHCLIENT_SET_HOSTNAME="no"' /etc/sysconfig/network/dhcp

# copy symbolic link, not the target
cp -P link new_link

# convert ssh private key to ppk file that can be used in putty (install putty-tools)
puttygen keyname -o keyname.ppk

# passwordless sudo 
echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

# "Device or resource busy"
lsof +D /path
