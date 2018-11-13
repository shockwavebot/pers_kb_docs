# add second ip address to an interface
ip address add 192.168.99.37/24 dev eth0

# disable ipv6
echo "
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
cat /proc/sys/net/ipv6/conf/eth0/disable_ipv6
echo 1 > /proc/sys/net/ipv6/conf/eth0/disable_ipv6

# disable dhcp to set change host name
sed -i '/^DHCLIENT_SET_HOSTNAME/c\DHCLIENT_SET_HOSTNAME="no"' /etc/sysconfig/network/dhcp
