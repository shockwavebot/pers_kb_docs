# check status, default policy 
iptables -L



#####################################################################################################################
## http://server ## *** set this at KVM server where VM is hosted **** maia or thunderx9
sudo iptables -t nat -I PREROUTING -d 10.100.96.56 -p tcp --dport 80 -j DNAT --to-destination 192.168.122.155
sudo iptables -t nat -I PREROUTING -d 10.100.96.57 -p tcp --dport 8443 -j DNAT --to-destination 192.168.122.152:8443

#and you need to delete "reject rules" from "forward" chain
sudo iptables -L FORWARD --line-number
sudo iptables -D FORWARD 5

sudo iptables -t nat -L PREROUTING # to verify

#####################################################################################################################
