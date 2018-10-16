# Test TCP port
nc -z 129.35.10.31 1500
telenet 10.216.73.237 1600

# add route
sudo ip route add 44.81.0.0/18 via 44.81.0.1 dev eth0
