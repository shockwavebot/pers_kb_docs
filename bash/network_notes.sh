# Test TCP port
nc -z 129.35.10.31 1500
telenet 10.216.73.237 1600

# add route
sudo ip route add 44.81.0.0/18 via 44.81.0.1 dev eth0
# add default route
sudo ip route add default via 192.168.122.1 dev eth0
# permanent setup default route
echo 'default 192.168.122.1'|tee -a /etc/sysconfig/network/ifroute-eth0

# disable dhcp to set change host name
sed -i '/^DHCLIENT_SET_HOSTNAME/c\DHCLIENT_SET_HOSTNAME="no"' /etc/sysconfig/network/dhcp
