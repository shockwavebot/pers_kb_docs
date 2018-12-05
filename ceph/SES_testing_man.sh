##################################################################################

##################################################################################


# to check exact version of pgk
zypper se -s ceph
zypper se -s deepsea
zypper se -s openattic

##################################################################################
@MASTER:
zypper in -y deepsea
sed -i '/#interface: 0.0.0.0/c\interface: 10.84.149.227' /etc/salt/master
sed -i '/#master: salt/c\master: rock227.qa.prv.suse.net' /etc/salt/minion
systemctl enable salt-master.service;systemctl start salt-master.service
systemctl enable salt-minion.service;systemctl start salt-minion.service

@MINIONs:
zypper in -y salt-minion
sed -i '/#master: salt/c\master: rock227.qa.prv.suse.net' /etc/salt/minion
systemctl enable salt-minion.service;systemctl start salt-minion.service

sed -i '/server cz.pool.ntp.org iburst/c\server ses5node1 iburst' /etc/ntp.conf

@ALL (NTP):
 # 1. Stop the NTP service
 # 2. As root ntpdate -bs 10.130.33.201 to reset your time to something close
 # 3. Start the NTP service
systemctl stop ntpd
ntpdate -bs de.pool.ntp.org
systemctl start ntpd
sntp -S -c ses5node1

################
DEEPSEA/SALT commands
################

salt-key --accept-all -y
salt \* test.ping

salt-key --accept-all -y
sleep 1
salt \* test.ping || echo
sleep 1
salt-key --accept-all -y
sleep 1
salt \* test.ping || echo


# salt \* grains.setval deepsea True
echo "deepsea_minions: '*'" > /srv/pillar/ceph/deepsea_minions.sls

# disable restart in stage 0 # removed in ses5.5 M8
# sed -i 's/default/default-no-update-no-reboot/g' /srv/salt/ceph/stage/prep/master/init.sls
# sed -i 's/default/default-no-update-no-reboot/g' /srv/salt/ceph/stage/prep/minion/init.sls

# bug#1100083 workaround -> resolved in M5
# sed -i 's/-collector/--collector/g' /srv/salt/ceph/monitoring/prometheus/exporters/node_exporter.sls

echo "deepsea_minions: '*'" > /srv/pillar/ceph/deepsea_minions.sls
echo "master_minion: monses0.qalab" > /srv/pillar/ceph/master_minion.sls
salt-run state.orch ceph.stage.0
salt-run state.orch ceph.stage.1

echo "declare -x POL_CFG=/srv/pillar/ceph/proposals/policy.cfg" >> ~/.profile; .  ~/.profile
echo "\
# Cluster assignment
cluster-ceph/cluster/*.sls
# Common configuration
config/stack/default/global.yml
config/stack/default/ceph/cluster.yml
# Role assignment
role-master/cluster/ses5node1*.sls
role-admin/cluster/ses5node[12345]*.sls
role-mon/cluster/ses5node[123]*.sls
role-mgr/cluster/ses5node[123]*.sls
role-mds/cluster/ses5node[23]*.sls
role-igw/cluster/ses5node[1]*.sls
role-rgw/cluster/ses5node[23]*.sls
role-ganesha/cluster/ses5node[34]*.sls
role-openattic/cluster/ses5node5*.sls
# Profile (Hardware) configuration
profile-default/cluster/*.sls
profile-default/stack/default/ceph/minions/*yml
" > /srv/pillar/ceph/proposals/policy.cfg
salt-run state.orch ceph.stage.2
salt-run state.orch ceph.stage.3
salt-run state.orch ceph.stage.4

echo 'mon allow pool delete = true' >> /srv/salt/ceph/configuration/files/ceph.conf.d/global.conf

# to verify roles:
salt '*' pillar.items roles

#checking the running services:
salt \* cmd.run "systemctl |grep ceph-osd@.\.service"

salt-run state.event pretty=True 		# Watching the Restarting
salt-run state.orch ceph.restart

salt-run state.orch ceph.restart.mon
salt-run state.orch ceph.restart.osd
salt-run state.orch ceph.restart.mds
salt-run state.orch ceph.restart.rgw
salt-run state.orch ceph.restart.igw
salt-run state.orch ceph.restart.ganesha

#############
CEPH commands
#############
ceph health detail
ceph -s
ceph osd lspools
ceph osd pool ls
ceph osd pool create test-pool 8 8 replicated
ceph osd pool ls|grep test
ceph osd pool rename test-pool pool-test
ceph osd application enable pool-test rbd
ceph mon stat
ceph mon_status -f json-pretty
ceph mon dump
ceph quorum_status -f json-pretty
ceph osd stat
ceph osd tree
rados df
ceph df

# TODO how to create a pool-based snapshot?

# Ceph logs
ls -la /var/log/ceph/*log

tail /var/log/ceph/ceph-client.rgw.ses5node1.log
tail /var/log/ceph/ceph-mgr.ses5node1.log
tail /var/log/ceph/ceph-mon.ses5node1.log
tail /var/log/ceph/ceph-osd.3.log
tail /var/log/ceph/ceph-osd.admin.log
tail /var/log/ceph/ceph.audit.log
tail /var/log/ceph/ceph.log

grep -ir err /var/log/ceph/*log

# PGs - placement groups
ceph osd pool get pool-test pg_num
ceph osd pool get pool-test all
ceph osd pool set pool-test pg_num 16
ceph osd pool set pool-test pgp_num 16
ceph pg dump_stuck inactive
ceph pg dump_stuck unclean
ceph pg dump_stuck stale
ceph pg ls|head
ceph pg map $(ceph pg ls|tail -n 1|awk '{print $1}')

# RBD
ceph osd pool create vm-pool 32 32
ceph osd pool application enable vm-pool rbd
ceph osd pool create rbd-disks 8 8
ceph osd pool application enable rbd-disks rbd

rbd create vm-img --size 1024 --pool vm-pool
rbd ls vm-pool
rbd --image vm-img -p vm-pool info
rbd resize --size 2048 --image vm-img -p vm-pool
rbd rm vm-img -p vm-pool

#RBD-snapshots
rbd create vm-img --size 1024 --pool vm-pool # creating a disk
rbd snap create vm-pool/vm-img@vm-img_snapname_test_date
rbd snap ls vm-pool/vm-img
rbd snap rollback vm-pool/vm-img@snapname #TODO
rbd snap rm vm-pool/vm-img@snapname #TODO
rbd snap purge vm-pool/vm-img #TODO
rbd clone vm-pool/my-image@my-snapshot vm-pool/new-image #TODO

salt \* cmd.run 'systemctl status ceph.target'
salt \* cmd.run 'systemctl stop ceph.target'
salt \* cmd.run 'systemctl start ceph.target'

#################################
##### Removing OSD - observe procees on ceph -w, wait for active + clean state)
#################################
ceph osd out osd.5
	# if some PGs remain stuck in the active+remapped state, then:
		ceph osd in osd.5
		ceph osd crush reweight osd.5 0
# Stopping the OSD by logging on the node where OSD is located:
systemctl stop ceph-osd@5.service
# Removing the OSD:#
# 1. # remove the osd from CRUSH map:
ceph osd crush remove osd.5
# 2. # remove the OSD authentication key
ceph auth del osd.5
# 3. # remove the OSD
ceph osd rm osd.5
# 4. # Check OSD tree (there is no osd.5 in the tree):
ceph osd tree
# 5. # Check system health
ceph -s

# Wipe disk to remove all data
mount|grep ceph-5
umount /var/lib/ceph/osd/ceph-5
ceph-disk zap /dev/sdc
sgdisk --zap-all /dev/sdc
sgdisk --clear --mbrtogpt /dev/sdc


# removing with deepsea:
salt-run disengage.safety
salt-run remove.osd 15

#################################
##### Adding OSD - WITH DEEPSEA
#################################
# 1. # ADD DISK TO THE SYSTEM (VM NEEDS TO BE RESTARTED)
qemu-img create -f raw /VMhdd/ses5node5-osd-2 30G
virsh attach-disk ses5node5 /VMhdd/ses5node5-osd-2 vdc --config --live --cache none
# 2. # RUN DEEPSEA stage 1 (discovery)
salt-run state.orch ceph.stage.1
salt-run proposal.populate name=disks_expand_v1
# 3. # Edit policy.cfg - replace the new profile-disks_expand_v1
# 4. # RUN DEEPSEA stages 2 and 3
salt-run state.orch ceph.stage.2
salt-run state.orch ceph.stage.3

salt \* cmd.run 'fdisk -l|grep Ceph'

#TODO: how to do it manually?

#################################
##### Cache tiering
#################################
ceph osd pool create cold-storage 32 32 replicated
ceph osd pool create hot-storage 32 32 replicated
ceph osd pool ls|egrep 'hot|cold'
ceph osd tier add cold-storage hot-storage
ceph osd tier cache-mode hot-storage writeback
ceph osd tier set-overlay cold-storage hot-storage
ceph osd pool set hot-storage hit_set_type bloom
ceph osd pool set hot-storage hit_set_count 3
ceph osd pool set hot-storage hit_set_period 1200 #20min
ceph osd pool set hot-storage target_max_bytes 20000000 #20MB
ceph osd pool application enable cold-storage rbd
ceph health
ceph -s
for i in 1 2 3 4 5;do base64 /dev/urandom | head --bytes=4MB > 4MB.random.txt.file.$i; rados -p hot-storage put obj_$i 4MB.random.txt.file.$i;done
echo "##### hot-storage ####";rados -p hot-storage ls;echo "#### cold-storage ####";rados -p cold-storage ls;echo "######################"
ceph osd tier remove-overlay cold-storage
ceph osd tier remove cold-storage hot-storage

#################################
##### Erasure coding
#################################
ceph osd erasure-code-profile ls
ceph osd erasure-code-profile set EC-profile
ceph osd erasure-code-profile set EC-profile crush-failure-domain=osd k=4 m=2 --force
ceph osd erasure-code-profile get EC-profile

ceph osd pool create EC_rbd_pool 8 8  erasure EC-profile
ceph osd pool application enable EC_rbd_pool rbd

for ((i=1;i<=10000;i++));do echo $i force is with you... >> /tmp/force.txt;done # this is 284K file
rados -p EC_rbd_pool put object.1 /tmp/force.txt
rados -p EC_rbd_pool ls
ceph osd map EC_rbd_pool object.1
# osdmap e819 pool 'EC_rbd_pool' (79) object 'object.1' -> pg 79.f560f2ec (79.4) -> up ([5,0,11,16,15,23], p5) acting ([5,0,11,16,15,23], p5)

# simulating OSD failures - 1st method
ceph osd out osd.0
ceph osd out osd.5
ceph osd map EC_rbd_pool object.1
# osdmap e831 pool 'EC_rbd_pool' (79) object 'object.1' -> pg 79.f560f2ec (79.4) -> up ([10,22,11,16,15,23], p10) acting ([10,22,11,16,15,23], p10)
ceph osd in  osd.0
ceph osd in  osd.5
ceph osd map EC_rbd_pool object.1
# osdmap e840 pool 'EC_rbd_pool' (79) object 'object.1' -> pg 79.f560f2ec (79.4) -> up ([5,0,11,16,15,23], p5) acting ([5,0,11,16,15,23], p5)

# simulating OSD failures - 2nd method
salt 'ses5node1*' cmd.run 'systemctl stop ceph-osd@0.service'
salt 'ses5node3*' cmd.run 'systemctl stop ceph-osd@5.service'
ceph osd map EC_rbd_pool object.1
rados -p EC_rbd_pool get object.1 /tmp/force.txt.after # while cluster in transition, not possible to get object TODO: is this a bug?
salt 'ses5node1*' cmd.run 'systemctl start ceph-osd@0.service'
salt 'ses5node3*' cmd.run 'systemctl start ceph-osd@5.service'
rados -p EC_rbd_pool get object.1 /tmp/force.txt.after
tail /tmp/force.txt.after

# ceph osd pool create EC_cephfs_pool_data 8 8  erasure EC-profile
# ceph osd pool create EC_cephfs_pool_metadata 8 8
# ceph osd pool application enable EC_cephfs_pool_data cephfs
# ceph osd pool set EC_cephfs_pool_data allow_ec_overwrites true
# ceph osd pool application enable EC_cephfs_pool_metadata cephfs
# ceph fs flag set enable_multiple true --yes-i-really-mean-it # experimental feature: multiple CephFS
# ceph fs new ec_cephfs EC_cephfs_pool_metadata EC_cephfs_pool_data
# # test creating rbd image from EC pool
# ceph osd pool create ec-metadata 16 16 replicated
# ceph osd pool application enable ec-metadata rbd
# ceph osd pool set EC_rbd_pool allow_ec_overwrites true
# rbd create ec-img --size 2048 --data-pool EC_rbd_pool --pool=ec-metadata


# base64 /dev/urandom | head --bytes=4MB > /tmp/object-A
# rados -p EC_rbd_pool put object.1 /tmp/object-A
# rados -p EC_cephfs_pool put object.1 /tmp/object-A
# rados -p EC_rbd_pool ls
# rados -p EC_cephfs_pool ls
# ceph osd map EC_rbd_pool object.1
# ceph osd map EC_cephfs_pool object.1

# salt 'ses5node1*' cmd.run 'systemctl stop ceph-osd@0.service'
# salt 'ses5node3*' cmd.run 'systemctl stop ceph-osd@5.service'
# ceph osd map ECtemppool object.1

# salt 'ses5node3*' cmd.run 'systemctl stop ceph-osd@8.service'
# ceph osd map ECtemppool object.1

# salt 'ses5node2*' cmd.run 'systemctl start ceph-osd@5.service'
# salt 'ses5node5*' cmd.run 'systemctl start ceph-osd@2.service'
# salt 'ses5node3*' cmd.run 'systemctl start ceph-osd@8.service'

#################################
##### ADD/REMOVE SERVICE with DS
#################################

#################################
##### oA - openAttic web UI
#################################

#################################
##### RBD
#################################
ceph osd pool create rbd-test 32 32 replicated
ceph osd pool application enable rbd-test rbd

rbd create rbd-test/test_img_1 --size 102400
rbd create rbd-test/test_img_2 --size 10240
rados df -p rbd-test
rados ls -p rbd-test -

ceph osd pool create rbd_test 16 16 replicated
rbd pool init rbd_test
rbd ls rbd_test
rbd info rbd_test/img_1

#################################
##### NFS- ganesha
#################################

#################################
##### IGW - iSCSI gateway
#################################

#################################
##### User management
#################################
ceph auth list

# add user and allow access to only one specific pool #TODO
# ceph auth add
# ceph auth get-or-create
# ceph auth get-or-create-key

ceph auth add client.lazar mon 'allow r' osd 'allow r pool=rbd-test'
ceph auth get client.lazar -o /etc/ceph/ceph.client.lazar.keyring
ceph auth get-or-create client.nemanja mon 'allow r' osd 'allow rw pool=rbd-test'
ceph auth get client.nemanja -o /etc/ceph/ceph.client.nemanja.keyring
ceph auth get-or-create client.stefan mon 'allow r' osd 'allow rw pool=rbd-test' -o stefan.keyring
ceph auth get-or-create-key client.petar mon 'allow r' osd 'allow rw pool=rbd-test' -o petar.key

ceph auth get client.lazar
ceph auth caps client.stefan mon 'allow r' osd 'allow rw pool=prague'
ceph auth caps client.nemanja mon 'allow rw' osd 'allow rwx pool=prague'
ceph auth caps client.petar mon 'allow *' osd 'allow *'

ceph auth del client.petar
ceph auth print-key client.nemanja

# user allowed to write and read only from one pool test case:
# ceph osd pool create rbd-test 8 8
echo "Rema dzedaj i veliki kralj je...." > /tmp/test.obj
rados -p rbd-test put object.3 /tmp/test.obj
rados -p rbd-test ls
ceph osd map rbd-test object.3

ceph -n client.lazar --keyring=/etc/ceph/ceph.client.lazar.keyring -s
rados -n client.lazar --keyring=/etc/ceph/ceph.client.lazar.keyring -p rbd-test ls
echo "test cephx" > test.obj2
rados -n client.lazar --keyring=/etc/ceph/ceph.client.lazar.keyring -p rbd-test put object.2 test.obj2
rados -n client.nemanja --keyring=/etc/ceph/ceph.client.nemanja.keyring -p rbd-test put object.2 test.obj2
rados -p rbd-test ls

#################################

############################################
##### Migration from filestore to bluestore #	TODO - not documented
############################################
salt '*' osd.report
salt-run proposal.peek 		# ???bug??? returing defaults, not the actual state: @/srv/modules/runners/proposal.py
salt-run proposal.populate nvme-spinner=True ratio=3 name=bluestore+waldb # why ratio 3?

# edit /srv/pillar/ceph/proposals/policy.cfg
salt-run state.orch ceph.stage.2
salt \* pillar.get storage

salt-run disengage.safety
salt-run state.orch ceph.migrate.osds # working only for healthy cluster

##################################
# Increasing debug log level
##################################
# to check current level:
ceph --admin-daemon /var/run/ceph/ceph-mon.ses5node1.asok config show |grep '"debug_'
# in runtime:
ceph tell osd.3 injectargs --debug-osd 5 --debug-ms 2
ceph tell osd.3 injectargs --debug-osd 0 --debug-ms 0
ceph tell mon.ses5node5 injectargs --debug-auth 5 --debug-ms 5
ceph tell mon.ses5node5 injectargs --debug-auth 0 --debug-ms 0


##################################

ceph osd pool mksnap

PROBLEM: feature set mismatch
# [ 5540.015074] libceph: mon0 192.168.100.153:6789 feature set mismatch, my 106b84a842a42 < server's 40106b84a842a42, missing 400000000000000
# [ 5540.015482] libceph: mon0 192.168.100.153:6789 missing required protocol features
SOLUTION:
ceph osd crush tunables legacy
ceph osd crush show-tunables
# PROBLEM: HEALTH_WARN crush map has straw_calc_version=0
# SOLUTION:
ceph osd crush tunables hammer


###########################################################################
# DESTROY CEPH CLUSTER
###########################################################################
salt '*' cmd.run 'systemctl stop ceph.target'

salt-run disengage.safety
salt-run state.orch ceph.purge

salt '*' cmd.run 'systemctl stop ceph-osd.target'
salt '*' cmd.run 'systemctl disable ceph-osd.target'
salt '*' cmd.run 'pkill ceph-osd'
salt '*' cmd.run 'umount /var/lib/ceph/osd/*'
salt '*' cmd.run 'for d in b c d e; do ceph-disk zap /dev/sd$d; done'
salt '*' cmd.run 'for d in b c d e; do sgdisk --zap-all /dev/sd$d; done'

salt '*' cmd.run lsblk 		# to verify
###########################################################################

###########################################################################
# TESTING OTHER LINUX CLIENTS (UBUNTU, REDHAT)
###########################################################################
apt list --installed | grep ceph # apt-get install ceph-common
rpm -qa|grep ceph # yum install -y ceph-common

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
systemctl restart sshd
service ssh restart

CLIENT_HOST=192.168.100.183
scp /etc/ceph/ceph.conf root@${CLIENT_HOST}:/etc/ceph/
scp /etc/ceph/ceph.client.admin.keyring root@${CLIENT_HOST}:/etc/ceph/

# ERROR:
# 2017-09-27 15:02:00.757808 7f87f0f11b40  0 librados: client.admin authentication error (1) Operation not permitted
# couldn't connect to cluster: (1) Operation not permitted
# SOLUTION:
# @cluster: ceph osd crush tunables legacy; ceph osd crush show-tunables

# OPTION 2:
# Thanks a lot, I removed the line "tunable chooseleaf_stable 1" from the crushmap and it works now !

ceph osd crush show-tunables
{
    "choose_local_tries": 0,
    "choose_local_fallback_tries": 0,
    "choose_total_tries": 50,
    "chooseleaf_descend_once": 1,
    "chooseleaf_vary_r": 1,
    "chooseleaf_stable": 1,
    "straw_calc_version": 1,
    "allowed_bucket_algs": 54,
    "profile": "jewel",
    "optimal_tunables": 1,
    "legacy_tunables": 0,
    "minimum_required_version": "jewel",
    "require_feature_tunables": 1,
    "require_feature_tunables2": 1,
    "has_v2_rules": 1,
    "require_feature_tunables3": 1,
    "has_v3_rules": 0,
    "has_v4_buckets": 1,
    "require_feature_tunables5": 1,
    "has_v5_rules": 0
}

{
    "choose_local_tries": 2,
    "choose_local_fallback_tries": 5,
    "choose_total_tries": 19,
    "chooseleaf_descend_once": 0,
    "chooseleaf_vary_r": 0,
    "chooseleaf_stable": 0,
    "straw_calc_version": 0,
    "allowed_bucket_algs": 22,
    "profile": "argonaut",
    "optimal_tunables": 0,
    "legacy_tunables": 1,
    "minimum_required_version": "hammer",
    "require_feature_tunables": 0,
    "require_feature_tunables2": 0,
    "has_v2_rules": 1,
    "require_feature_tunables3": 0,
    "has_v3_rules": 0,
    "has_v4_buckets": 1,
    "require_feature_tunables5": 0,
    "has_v5_rules": 0
}

rados -n client.admin --keyring=/etc/ceph/ceph.client.admin.keyring -p rbd-disks ls
rados -p rbd-disks ls
rbd create disk05 --size 2048 --pool rbd-disks
rbd -p rbd-disks ls

rbd map disk05 --pool rbd-disks --id admin
rbd showmapped
sgdisk --largest-new=1 /dev/rbd0
mkfs.xfs /dev/rbd0p1 -f
umount /mnt -f
mount /dev/rbd0p1 /mnt
base64 /dev/urandom | head --bytes=100MB > /mnt/rbd-test-mnt.random.txt.file
ll /mnt
umount /mnt -f
rbd unmap /dev/rbd0

###########################################################################
# SIMULATING DISK FAILURE
###########################################################################
# monitoring the cluster with ceph -w
echo 1 > /sys/block/vdd/vdd2/make-it-fail

# TESTED : 2s from failure till OSD marked as down
############################################################################

############################################################################
# Erasure coded CephFS data pool
############################################################################
ceph osd erasure-code-profile set ec_profile crush-failure-domain=osd k=4 m=2 --force
ceph osd pool create cephfs_ec_data 8 8 erasure ec_profile
ceph osd pool create cephfs_ec_metadata 8 8
ceph osd pool application enable cephfs_ec_data cephfs
ceph osd pool application enable cephfs_ec_metadata cephfs
ceph osd pool set cephfs_ec_data allow_ec_overwrites true
ceph fs flag set enable_multiple true --yes-i-really-mean-it
ceph fs new ec_cephfs cephfs_ec_metadata cephfs_ec_data
ceph fs ls
ceph auth list 2>/dev/null|grep -A 1 client.admin|grep key| awk -F ":" '{print $2}'|tr -d ' ' > /etc/ceph/admin.secret
mount -t ceph -o mds_namespace=ec_cephfs ses5node2:/ /mnt -o name=admin,secretfile=/etc/ceph/admin.secret
############################################################################

###########################################################################
# TESTING COMPRESSION
###########################################################################
# algorithms: 	none, zstd, snappy, lz4, zlib
# mode: 		none, aggressive, passive, force

POOl_NAME=p1
ceph osd pool create $POOl_NAME 8 8
ceph osd pool application enable $POOl_NAME rbd
ceph osd pool set $POOl_NAME compression_algorithm zstd
ceph osd pool set $POOl_NAME compression_mode force
ceph osd pool set $POOl_NAME compression_required_ratio .9
ceph osd pool set $POOl_NAME compression_max_blob_size ???
ceph osd pool set $POOl_NAME compression_min_blob_size ???

rbd create disk01 --size 2048 --pool $POOl_NAME
rbd -p $POOl_NAME ls
rbd map disk01 --pool $POOl_NAME --id admin
rbd showmapped
DEVICE=rbd2
sgdisk --largest-new=1 /dev/$DEVICE
mkfs.xfs /dev/${DEVICE}p1 -f
umount /mnt -f
mount /dev/${DEVICE}p1 /mnt
# COPY

rados df|grep $POOl_NAME # doesn't show compressed size if compression is done...

############################################################################


###########################################################################
# MAINTANANCE UPDATES
###########################################################################
# DEPLOYMENT OF early milestone, M11
# disable the iso repos
salt \* cmd.run 'zypper mr -d 1 2 3'
# register SCC repos
salt \* cmd.run "SUSEConnect -r CODE -e mstanojlovic@suse.com"
salt \* cmd.run "SUSEConnect -p ses/5/x86_64 -r CODE -e mstanojlovic@suse.com"
# check if there are updates available
zypper lu|egrep 'deepsea|ceph|salt|python'
# perform updates
salt-run state.orch ceph.stage.0


###########################################################################





###########################################################################
# IP TABLES for setting up access to openAttic on VMs
###########################################################################
## http://server ## *** set this at KVM server where VM is hosted **** maia or thunderx9
# iptables -t nat -I PREROUTING -d 10.161.32.49 -p tcp --dport 80 -j DNAT --to-destination 192.168.122.155
iptables -t nat -I PREROUTING -d 10.161.32.49 -p tcp --dport 80 -j DNAT --to-destination 192.168.122.220
iptables -t nat -I PREROUTING -d 10.100.96.56 -p tcp --dport 80 -j DNAT --to-destination 192.168.122.155
# 10.100.96.56 - KVM host machine (thunderx9)
# 192.168.122.155 - VM with web app running (ses5node5 - openattic)
# HOWTO check if its set ?

#iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
## http://server:8198
#iptables -t nat -A PREROUTING -j DNAT -p tcp --dport 8198 --to 192.168.123.201:80
## needed for all
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT

#and you need to delete "reject rules" from "forward" chain
iptables -L FORWARD --line-number
iptables -D FORWARD 5

iptables -t nat -L PREROUTING # to verify
###########################################################################

# TC: Migrate(convert) replicated pool to EC pool by using Cache Tier

# preparation: deleting pool if they exist
ceph osd pool delete mig_test_rpl_pool mig_test_rpl_pool --yes-i-really-really-mean-it
ceph osd pool delete new_ec_pool new_ec_pool --yes-i-really-really-mean-it
# create replicated pool
ceph osd pool create mig_test_rpl_pool 16 16 replicated
ceph osd pool application enable mig_test_rpl_pool rbd
# add obj into the pool
for i in 1 2 3 4 5
do
  file_name=/tmp/random_${i}.txt
  openssl rand -base64 1000000 -out $file_name # 1.3MB
  rados -p mig_test_rpl_pool put object_${i} $file_name
  ceph osd map mig_test_rpl_pool object_${i}
done
rados -p mig_test_rpl_pool ls|grep object
# create new EC pool
ceph osd pool create new_ec_pool 16 16 erasure default
ceph osd pool application enable new_ec_pool rbd
# setup cache tier
ceph osd tier add new_ec_pool mig_test_rpl_pool --force-nonempty
ceph osd tier cache-mode mig_test_rpl_pool forward --yes-i-really-mean-it
# Force the cache pool to move all objects to the new pool
rados -p mig_test_rpl_pool cache-flush-evict-all
# Switch all clients to the new pool
ceph osd tier set-overlay new_ec_pool mig_test_rpl_pool
# verify all objects are in the new EC pool
rados -p mig_test_rpl_pool ls|grep object || echo "Pool empty: OK"
rados -p new_ec_pool ls|grep object
# remove the overlay and the old cache pool 'testpool'
ceph osd tier remove-overlay new_ec_pool
ceph osd tier remove new_ec_pool mig_test_rpl_pool














































===============================================================================================
-- OS CHECK and CONFIG (5 terminals) --
===============================================================================================
ip a s dev eth0|grep inet
hostname -f
cat /proc/sys/net/ipv6/conf/eth0/disable_ipv6
systemctl is-enabled apparmor
systemctl is-enabled SuSEfirewall2

echo 'default 192.168.100.1' >> /etc/sysconfig/network/ifroute-eth0
echo 'nameserver 192.168.100.1' >> /etc/resolv.conf
systemctl restart network
ping download.suse.de

	# transfer the root public key

@ VM HOST:
cat ~/.ssh/id_rsa.pub
> ~/.ssh/known_hosts

@ VMs:
mkdir -p /root/.ssh/
vi /root/.ssh/authorized_keys

	# get the install packages and configure repos

cd /tmp
wget http://download.suse.de/install/SLE-12-SP3-Server-RC1/SLE-12-SP3-Server-DVD-x86_64-RC1-DVD1.iso
zypper mr -d SLES12-SP3-12.3-0
zypper ar -t yast2 -c -f "iso:/?iso=/tmp/SLE-12-SP3-Server-DVD-x86_64-RC1-DVD1.iso" SLES12-SP3-12.3-0-local
zypper lr

wget http://download.suse.de/install/SUSE-Enterprise-Storage-5-Milestone6/SUSE-Enterprise-Storage-5-DVD-x86_64-Milestone6-DVD1.iso
wget http://download.suse.de/install/SUSE-Enterprise-Storage-5-Milestone6/SUSE-Enterprise-Storage-5-DVD-x86_64-Milestone6-DVD2.iso
wget http://download.suse.de/install/SUSE-Enterprise-Storage-5-Milestone6/SUSE-Enterprise-Storage-5-Internal-x86_64-Milestone6-DVD.iso

zypper ar -c -f "iso:/?iso=/tmp/SUSE-Enterprise-Storage-5-DVD-x86_64-Milestone6-DVD1.iso" SESdvd1
zypper ar -c -f "iso:/?iso=/tmp/SUSE-Enterprise-Storage-5-DVD-x86_64-Milestone6-DVD2.iso" SESdvd2
zypper ar -c -f "iso:/?iso=/tmp/SUSE-Enterprise-Storage-5-Internal-x86_64-Milestone6-DVD.iso" SESinternal
zypper lr

===============================================================================================
[DONE WITH AUTOYAST]
===============================================================================================
	# enable virsh console: [DONE WITH AUTOYAST]

sed -i '/GRUB_CMDLINE_LINUX_DEFAULT="resume=/dev/vda1 splash=silent quiet showopts"/c\GRUB_CMDLINE_LINUX_DEFAULT="resume=/dev/vda1 splash=silent quiet showopts console=ttyS0"' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

	# disabling ipv6 [DONE WITH AUTOYAST]

echo "
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
cat /proc/sys/net/ipv6/conf/eth0/disable_ipv6
echo 1 > /proc/sys/net/ipv6/conf/eth0/disable_ipv6
	# disable SuSEfirewall2 and apparmor [DONE WITH AUTOYAST]
	# enable and configure ntpd [DONE WITH AUTOYAST]

# !!! DO IT AFTER YOU PUT THERE CORRECT HOST NAME
# disabled hostname obtaining from DHCP
# sed -i '/^DHCLIENT_SET_HOSTNAME/c\DHCLIENT_SET_HOSTNAME="no"' /etc/sysconfig/network/dhcp

echo "server cz.pool.ntp.org iburst" >> /etc/ntp.conf
systemctl enable ntpd;systemctl start ntpd;systemctl status ntpd

# cloning the original VM (they have to be shut down)
virt-clone --original sles12sp3rc1 --name ses5node1 --file=/VMhdd/ses5node1.qcow2
virt-clone --original sles12sp3rc1 --name ses5node2 --file=/VMhdd/ses5node2.qcow2
virt-clone --original sles12sp3rc1 --name ses5node3 --file=/VMhdd/ses5node3.qcow2
virt-clone --original sles12sp3rc1 --name ses5node4 --file=/VMhdd/ses5node4.qcow2
virt-clone --original sles12sp3rc1 --name ses5node5 --file=/VMhdd/ses5node5.qcow2


# NETWORK SETUP
echo "BOOTPROTO='static'
STARTMODE='auto'
IPADDR='192.168.100.151/24'" >/etc/sysconfig/network/ifcfg-eth0
hostname ses5node1
echo "ses5node1.qatest" > /etc/hostname

echo "BOOTPROTO='static'
STARTMODE='auto'
IPADDR='192.168.100.152/24'" >/etc/sysconfig/network/ifcfg-eth0
hostname ses5node2
echo "ses5node2.qatest" > /etc/hostname

echo "BOOTPROTO='static'
STARTMODE='auto'
IPADDR='192.168.100.153/24'" >/etc/sysconfig/network/ifcfg-eth0
hostname ses5node3
echo "ses5node3.qatest" > /etc/hostname

echo "BOOTPROTO='static'
STARTMODE='auto'
IPADDR='192.168.100.154/24'" >/etc/sysconfig/network/ifcfg-eth0
hostname ses5node4
echo "ses5node4.qatest" > /etc/hostname

echo "BOOTPROTO='static'
STARTMODE='auto'
IPADDR='192.168.100.155/24'" >/etc/sysconfig/network/ifcfg-eth0
hostname ses5node5
echo "ses5node5.qatest" > /etc/hostname

@ALL:
echo "\
192.168.100.151 	ses5node1.qatest 		ses5node1
192.168.100.152 	ses5node2.qatest 		ses5node2
192.168.100.153 	ses5node3.qatest 		ses5node3
192.168.100.154 	ses5node4.qatest 		ses5node4
192.168.100.155 	ses5node5.qatest 		ses5node5" >> /etc/hosts

============================================================================


#################################
##### Adding OSD - WITH DEEPSEA # OBSOLETE
#################################
# 1. # ADD DISK TO THE SYSTEM (VM NEEDS TO BE RESTARTED)
qemu-img create -f raw /VMhdd/ses5node5-osd-2 30G
virsh attach-disk ses5node5 /VMhdd/ses5node5-osd-2 vdc --config --live --cache none
# 2. # RUN DEEPSEA stage 1 (discovery)
salt-run state.orch ceph.stage.1
find /srv/pillar/ceph/proposals/profile* -name "ses5node5*"
# 3. # Delete the obsolete sls and yml files from pillar (profiles which are not used any more)
# 4. # RUN DEEPSEA stages 2 and 3
salt-run state.orch ceph.stage.2
salt-run state.orch ceph.stage.3

salt \* cmd.run 'fdisk -l|grep Ceph'


##############################
# SLE 15 SES6
##############################
zypper ar -f "iso:/?iso=/repo_ISOs/SLE-15-SP1-Installer-DVD-x86_64-Build91.1-Media1.iso" sle15sp1_m1
zypper ar -f "iso:/?iso=/repo_ISOs/SLE-15-SP1-Installer-DVD-x86_64-Build91.1-Media2.iso" sle15sp1_m2
zypper ar -f "iso:/?iso=/repo_ISOs/SLE-15-SP1-Installer-DVD-x86_64-Build91.1-Media3.iso" sle15sp1_m3
