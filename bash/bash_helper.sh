# example of function defined in ~/.bashrc
function ssh_to_db {
    [[ $# -ne 1 ]] && { echo "ERR: Missing argument. Enter db trigram. Example: nca" >&2; return 2; }
    hash envinfo || { echo "ERR: Attach to your env." >&2; return 3; }
    ssh enterprisedb@$(envinfo|grep $1|awk '{print $4}')
}

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

# execute local script over ssh
ssh ses5node1 'bash -s' < ./tst.sh ses5node1

# remote exec ssh block 
ssh root@$hostname << EOSSH >> $LOG 2>&1
#commands
EOSSH

# change password without prompt
echo 'qatest:remaCAR-1'|chpasswd

#################################################
# encrypted USB drive
# create # cryptsetup installed 
sudo cryptsetup -yv create luksOpen /dev/sdc1
# mount
dmesg|tail
lsblk # or: sudo fdisk -l
sudo cryptsetup luksOpen /dev/sdc1 LUKS01
sudo mount /dev/mapper/LUKS01 /mnt
#unmount
umount /mnt
sudo cryptsetup luksClose LUKS01
#################################################

# grep ip regex
grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"

# create random text file of specific size 
base64 /dev/urandom | head --bytes=4MB > size.4MB.random.txt.file
openssl rand -base64 10000000 -out /tmp/random.txt # 13MB # better way 
dd if=/dev/zero of=speed_test_temp_file  bs=1024  count=102400

# unpack tar.gz to a specific directory
tar -xvf file.tar.gz -C /path/to/dir 

# generate ssh key without prompt - for using in scripts
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa; cat ~/.ssh/id_rsa.pub
sudo sed -i '/StrictHostKeyChecking/c\StrictHostKeyChecking no' /etc/ssh/ssh_config

# tcp dump
tcpdump -s0 -w /tmp/trace -i eth0

# pronalazenje najvecih fajlova, files with most used space ond disk, occupancy, biggest files
du -a / 2>/dev/null| sort -n -r | head -n 15
find -type f -exec du -Sh / {} + 2>/dev/null | sort -rh | head -n 5

# check available memory on the host
cat /proc/meminfo |grep MemTotal

# check whic TCP port application is using 
ss -l -p -n|grep <PID>|<user>|<process_name>

# Date format
date +%Y-%m-%d' '%H:%M:%S

# Calculate date in the future 
date -d "2017-03-05 +90 days" '+%Y-%m-%d'

# list all the directories in the path variable
ls -la $(echo $LIBPATH|tr ':' '\n')

# sabiranje svih brojeva iz fajla
sum=0;while read NUM && [[ $num == +([[:digit:]]) ]];do (( sum += NUM ));done < FILE_NAME; (( gb = sum/1024/1204/1024 ));echo $gb GB

#Change case in a string
tr '[:upper:]' '[:lower:]'

# Obrisati fajlove starije od 90 dana
find . -xdev -type f -name "rman_backup*" -mtime +90 -exec ls -l {} \;
find . -xdev -type f -name "rman_backup*" -mtime +90 -exec rm -rf {} \;
# Zauzeti FS
df|awk '{if($4>=90 || $3==0)print}'

# Nalazi sve fajlove koji su kreirani u zadnjih 10 min
find -mmin +0 -mmin -10
find . -mtime +3 | xargs rm -Rf

# {} array of values with step 
echo {1..15..4} # -> 1 5 9 13

# CUT za secenje stringa
cut -c1-3 #sece i ostavlja samo prva 3 karaktera stringa

# Replacement zameniti deo stringa 
resultat=${original_sting/$sub_string/$replacement_string}




