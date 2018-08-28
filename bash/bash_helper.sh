function num_of_free_disks {
	DISKS=$(lsblk|grep disk|awk '{print $1}')
	echo 'Disks present on the host ' $HOSTNAME ' : ' $DISKS
	FREE_DISKS='';for i in $DISKS;do lsblk|grep part|grep $i >/dev/null 2>&1|| FREE_DISKS=${FREE_DISKS}\ $i;done
	echo "Free disks are: " $FREE_DISKS
	NUMBER_OF_FREE_DISKS=$(echo $FREE_DISKS|wc -w)
	echo $NUMBER_OF_FREE_DISKS
}

# OBTAINING HOST DOMAIN
# Directly from the host
FQDN=$(hostname -f 2>/dev/null || cat /etc/hostname);export DOMAIN_NAME=${FQDN#*\.};echo "FQDN: " $FQDN
FQDN=$(salt -C 'I@roles:rgw' grains.item fqdn --out yaml|grep fqdn|tail -n 1|sed 's/fqdn: //g');echo "Hostname: " $FQDN
# By using SALT
DOMAIN_NAME=$(salt-call grains.item domain --out yaml|grep domain|sed 's/domain: //g');echo "Domain: " $DOMAIN_NAME
# Getting the IP BASE of the host - needed when all hosts are in virtual network 192.168.x.x
IP=$(ip route get 8.8.8.8| grep src| sed 's/.*src \(.*\)$/\1/g');export IPBASE=${IP%\.*};echo "IP base is: " $IPBASE

LOG_FILE=/tmp/NFS_HA_QA_test_$(date +%H_%M_%S).log


targetcli ls|egrep ".*[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}.*"

# ssh setup 
sudo sed -i '/StrictHostKeyChecking/c\StrictHostKeyChecking no' /etc/ssh/ssh_config
# passwordless sudo as root
echo 'sesqa ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers


################################################
BASH: razlika izmedju [] and [[ ]] !!!
 	za -n $STRING radi sa [[ ]]
 	za $STRING -eq "STRING" radi sa []


# copy file with a progress bar 
rsync -ah --progress source destination

# write to a file from a script 
cat <<EOF > /tmp/script_name
#!/bin/bash
# script code here 
EOF

# get UUID of the disk
sudo blkid /dev/sda  

# remote exec ssh block 
ssh root@$hostname << EOSSH >> $LOG 2>&1
#commands
EOSSH

# change password without prompt
echo 'qatest:remaCAR-1'|chpasswd
