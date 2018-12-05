export PS1='\e[1;91m[ceph:\w ]$ \e[m'

Ceph Cheatsheet: https://sabaini.at/pages/ceph-cheatsheet.html


systemctl start/stop ceph.target				# start/stop ceph service 
salt '*' cmd.run 'systemctl stop ceph.target'
salt '*' cmd.run 'systemctl start ceph.target'

ceph -s 									# cluster status
ceph status
ceph health
ceph osd stat 								# status od osds
ceph osd dump								# displays the OSD MAP
ceph osd tree

ceph mon dump 								# displays MONITOR MAP

ceph osd lspools | rados lspools | ceph osd pool ls
ceph osd pool create test_pool 32 32 replicated
ceph osd pool get test_pool  pg_num
ceph osd pool set test_pool  pg_num 32

ceph osd df tree 		# cluster utilization, full, occupancy

ceph -w 									# watch window for monitoring events on ceph cluster
ceph df

ceph osd dump | grep 'replicated size'		# get the number of object replicas

---------------------------------------------------------------------------------------------
ERROR: ceph pg: Error EACCES: access denied
SOLUTION description: add mgr in client.admin cap
SOLUTION command: ceph auth caps client.admin osd 'allow *' mds 'allow *' mon 'allow *' mgr 'allow *'
---------------------------------------------------------------------------------------------

---------------------------------------
# to find a location of the osd :
$ ceph osd find 4
{
    "osd": 4,
    "ip": "192.168.122.131:6800/4110",
    "crush_location": {
        "host": "ses-node1",
        "root": "default"
    }
}
---------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------
https://stackoverflow.com/questions/39589696/ceph-too-many-pgs-per-osd-all-you-need-to-know
https://stackoverflow.com/questions/40771273/ceph-too-many-pgs-per-osd
-------------------------------------------------------------------------------------------------------------------------------------
# to make a SUM of pgs per osd and pgs per pool:
ceph pg dump | awk '
 /^pg_stat/ { col=1; while($col!="up") {col++}; col++ }
 /^[0-9a-f]+\.[0-9a-f]+/ { match($0,/^[0-9a-f]+/); pool=substr($0, RSTART, RLENGTH); poollist[pool]=0;
 up=$col; i=0; RSTART=0; RLENGTH=0; delete osds; while(match(up,/[0-9]+/)>0) { osds[++i]=substr(up,RSTART,RLENGTH); up = substr(up, RSTART+RLENGTH) }
 for(i in osds) {array[osds[i],pool]++; osdlist[osds[i]];}
}
END {
 printf("\n");
 printf("pool :\t"); for (i in poollist) printf("%s\t",i); printf("| SUM \n");
 for (i in poollist) printf("--------"); printf("----------------\n");
 for (i in osdlist) { printf("osd.%i\t", i); sum=0;
   for (j in poollist) { printf("%i\t", array[i,j]); sum+=array[i,j]; sumpool[j]+=array[i,j] }; printf("| %i\n",sum) }
 for (i in poollist) printf("--------"); printf("----------------\n");
 printf("SUM :\t"); for (i in poollist) printf("%s\t",sumpool[i]); printf("|\n");
}'
-------------------------------------------------------------------------------------------------------------------------------------

# AUTH
ceph auth list

# adding block disk for VM
ceph osd pool create libvirt-pool 32 32
ceph osd lspools
rbd create libvirt-image –size 1024 –pool libvirt-pool
rbd ls libvirt-pool
rbd –image libvirt-image –p libvirt-pool info

# get a placement group map
ceph pg map 0.3e # where 0.3e is PG ID

# Support tips and tricks
ceph-disk list

#############################################
# Troubleshotting PGs
#############################################
ceph pg dump_stuck stale
ceph pg dump_stuck inactive
ceph pg dump_stuck unclean


#############################################


#############################################
# ISSUE: PG inconsistent.
#############################################
try: ceph pg repair
check osd.0.log
find object /var/lib/ceph/osd/osd.0/current/0.64_head# find ./ | grep [object_name]

1) set osd noout
2) shutdown the service of osd.0 and osd.20
3) remove the object by using ceph-objectstore-tool on both osd.0 and osd.20
ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-0/ --journal-path /var/lib/ceph/osd/ceph-0/journal --pgid 0.64  rbd_data.10eb238e1f29.0000000000006911 remove
ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-20/ --journal-path /var/lib/ceph/osd/ceph-20/journal --pgid 0.64  rbd_data.10eb238e1f29.0000000000006911 remove
4) start the service of osd.0 and osd.20
5) unset osd onout
#############################################

# Get pool details all params:
ceph osd pool get POOL_NAME all

# checking config options
ceph-conf --show-config | grep max_write_size
<
# [Bug 1061416] "rados df" not showing reduced occupancy after files deleted from rbd mounted disk
If you are not using the "discard" mount option, then you should explicitly run
"fstrim /mnt" after the deletion, to ensure that space reclaim is triggered.

# MDS performance
ceph daemonperf mds.ses5node2

# cache
ceph daemon osd.0 config show | grep rbd_cache
ceph tell osd.* injectargs '--rbd_cache_size=268435456'

# default object size in ceph cluster is 4MB, but this is for creating RBD images
rbd create mypool/myimage --size 102400 --object-size 8M

# put object in pool
base64 /dev/urandom | head --bytes=1MB > rnd_chars_file_1M_size
rados -p qatest put myobj01 rnd_chars_file_1M_size
# to list objects in pool
rados -p qatest ls
# remove object from pool
rados -p pool_name rm object_name

# testing performance
iperf3 to check network bandwith -> 25Gbps
ceph tell osd.<osd nr> bench
rados -p test_pool -t 16 bench 70000 write –no-cleanup

# checking the object store
ceph osd metadata 1 -f json-pretty | jq '.osd_objectstore'

#################################
##### CRUSH map
#################################
# see current map
ceph osd crush tree
ceph osd crush dump

# see CRUSH rules
ceph osd crush rule ls
ceph osd crush rule dump by_rack

# create a new CRUSH rule : failure domain: rack
ceph osd crush rule create-replicated by_rack default rack

# change the rule that pool uses
ceph osd pool set <pool-name> crush_rule <rule-name>

# CRUSH location
# see OSDs CRUSH location
# modify OSDs CRUSH location

# Customize a CRUSH map
ceph osd getcrushmap -o compiled-crushmap.map
crushtool -d compiled-crushmap.map -o decompiled-crushmap.map; cat decompiled-crushmap.map
# editing: vi decompiled-crushmap.map
crushtool -c decompiled-crushmap.map -o compiled-crushmap.map
ceph osd setcrushmap -i compiled-crushmap.map

# CRUSH map - create a new rule : failure domain: rack
ceph osd crush rule create-replicated by_rack default rack
ceph osd crush rule dump by_rack

# change the rule that pool uses
ceph osd pool set <pool-name> crush_rule <rule-name>

# MANUALLY EDITING THE CRUSH MAP
# list buckets
ceph osd crush tree
# create a new bucket
ceph osd crush add-bucket dc root
ceph osd crush add-bucket rack1 rack
ceph osd crush add-bucket rack2 rack
ceph osd crush add-bucket rack3 rack

# move device to a bucket
ceph osd crush move rack1 root=dc
ceph osd crush move rack2 root=dc
ceph osd crush move rack3 root=dc

ceph osd crush move sesqa4 rack=rack1
ceph osd crush move sesqa5 rack=rack1
ceph osd crush move sesqa6 rack=rack2
ceph osd crush move sesqa7 rack=rack2
ceph osd crush move sesqa8 rack=rack3
ceph osd crush move sesqa9 rack=rack3

# create new replicated rule with rack as failure domain
ceph osd crush rule create-replicated replicated_rack dc rack
ceph osd crush rule rm replicated_rule

# end CRUSH map section
#################################

# how to map object to a PGs and OSDs
ceph osd map pool_name object_name


# get show configuration
ceph -n mon.rock229 --show-config|grep mon_max_pg_per_osd

# set some custom conig
ceph config set mon_max_pg_per_osd 4000
