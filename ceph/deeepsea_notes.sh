#DS - deepsea

/srv/pillar					# minions configuration files
/srv/pillar/ceph			# DS config data
/srv/pillar/ceph/proposals	# Ceph cluster sls and yml files + policy.cfg
/srv/module/runners			# Python scripts (runners) executed on salt-master with salt-run
/srv/salt/					# salt state files (sls)
/srv/salt/_modules			# Python scripts (modules) executed on minions EXAMPLE: /srv/salt/_modules/rgw.py
/srv/salt/ceph				# DS sls files used for orchestration (stage sls files)
/srv/salt/ceph/stage		# orchestration files

#################################################################
# Customizing the deployment
#################################################################
mkdir /srv/salt/ceph/logrotate
vi /srv/salt/ceph/logrotate/init.sls

rotate logs:
  cmd.run:
    - name: "/usr/sbin/logrotate /etc/logrotate.conf; echo 'logs are rotated...'>/var/log/losgsrotated_msg"

# testing the state
salt ses5node1.qatest state.apply ceph.logrotate

vi /srv/salt/ceph/stage/prep/logrotate.sls

logrotate:
  salt.state:
    - tgt: '*'
    - sls: ceph.logrotate

# verify the orchestration file works
salt-run state.orch ceph.stage.prep.logrotate

# custom orchestration sls file
vi /srv/salt/ceph/stage/prep/custom.sls

include:
  - .logrotate
  - .master
  - .minion

vi /srv/pillar/ceph/stack/global.yml

stage_prep: custom

salt-run state.orch ceph.stage.0
#################################################################

# Support tips and tricks
salt <admin_node> state.apply ceph.mds.key 						# to create a mds client key
salt-run proposal.populate journal_size=10G						# to change journal partition size
salt-run proposal.populate journal-size=10G format='filestore' 	# to choose store type
salt-run proposal.populate encryption=dmcrypt

# profile example:
      /dev/sdb:
        encryption: dmcrypt
        format: bluestore
        wal: /dev/sdb
        wal_size: 1G
        db: /dev/sdb
        db_size: 1G

# import from cluster created by ceph-deploy
salt-run populate.engulf_existing_cluster

# script is at /srv/modules/runners/populate.py
# 1016 def _replace_cluster_network_with_existing_cluster(osd_addrs, public_networks=[]):
# 1017     """
# 1018     Replace proposed cluster_network with cluster_network(s) of the running cluster.
# 1019     If a public_networks is provided, pass that along as a fallback for
# 1020     _get_existing_cluster_networks() to use when cluster_network is found to
# 1021     be 0.0.0.0, and to filter the public_networks from the derived cluster_networks.
# 1022     Returns { 'ret': True/False, 'cluster_networks': list of networks }
# 1023     """
# 1024     cluster_networks = _get_existing_cluster_networks(osd_addrs, public_networks)
# 1025     if not cluster_networks:
# 1026         #log.error("Failed to determine cluster's cluster_network.")
# 1027         return { 'ret': True, 'cluster_networks': [] }

# get network minion interfaces
salt '*' network.interfaces

# migration from filestore to bluestore
salt-run state.orch ceph.migrate.policy
salt-run state.orch ceph.migrate.osds
salt-run state.orch ceph.migrate.nodes

salt-run status.report

salt-run proposal.populate name=disk_update_v2

# openattic key file permissions after deepsea stage 3
salt 'master*' state.apply ceph.openattic.key
salt -I roles:openattic state.apply ceph.openattic.keyring

# how to target specific role
salt -C 'I@roles:ganesha' cmd.run

# check cluster roles:
salt \* pillar.get roles
salt \* pillar.items roles

salt-run proposal.peek
salt-run proposal.help
salt-run proposal.populate

salt '*' osd.report
salt-run disengage.safety
salt-run state.orch ceph.migrate.osds

salt-run remove.osd 15 force=True

# @minion
salt-call -l debug cephdisks.list 2>&1

# CUSTOM CONFIGURATION files
/srv/salt/ceph/configuration/files/ceph.conf.d 		# ceph.conf
/srv/salt/ceph/configuration/files/ceph.conf.j2		# ceph.conf
/srv/salt/ceph/ganesha/files/ganesha.conf.j2		# NFS
/srv/salt/ceph/igw/files/lrbd.conf.j2				# IGW

cat /srv/salt/ceph/configuration/files/ceph.conf.d/README
/srv/salt/ceph/configuration/files/ceph.conf.d/[global,osd,mon,mgr,mds,client].conf

ceph --admin-daemon /var/run/ceph/ceph-osd.*.asok config get osd_max_write_size
ceph -n osd.0 --show-config
ceph tell osd.* config set osd_max_write_size 10000

#####################################################################################3
Since this is not directly supported by DeepSea,
would disabling the service start/enable be sufficient?
That is, copy /srv/salt/ceph/ganesha/default.sls to /srv/salt/ceph/ganesha/ha.sls.
Remove the .service entry.  The file before is

include:
 - .keyring
 - .install
 - .configure
 - .service

and after

include:
 - .keyring
 - .install
 - .configure

Add the following to /srv/pillar/ceph/stack/global.yml

ganesha_init: ha

Run Stage 2 and then Stage 4 should complete successfully.

This is the general strategy in customizing DeepSea when req  uirements are
different than what is currently supported.
This still gives the advantage of pushing keyrings,
 configurations and installing packages on newly added ganesha nodes,
 but the start/restart would be off limits from DeepSea.
#####################################################################################3

# change default deepsea settings:
1. edit /srv/pillar/ceph/stack/ceph/cluster.yml
2. salt '*' saltutil.pillar_refresh
3. salt '*' pillar.items # to verify

# selecting minions of certan type: MON MDS MGR ...
salt-run select.minions roles=mon

# when is used?
salt '*' saltutil.sync_all

# SAP customer use case OSD config :
salt-run proposal.populate ratio=12 wal-size=1g db-size=59g name=prod

# disable restart in stage.0
sed -i 's/default/default-no-update-no-reboot/g' /srv/salt/ceph/stage/prep/master/init.sls
sed -i 's/default/default-no-update-no-reboot/g' /srv/salt/ceph/stage/prep/minion/init.sls

# when something running too long
salt-run jobs.active

# troubleshooting zypper errors in stage 0
zypper if librados2
rpm -q --provides librados2
zypper if python3-rados


# checking grains
salt hera* grains.get ceph

# stage 2 populate yaml files
/srv/pillar/ceph/stack/ceph/minions/*.yml
/srv/pillar/ceph/stack/default/ceph/minions/*.yml

# before stage 3 advise which osds will be deployed
salt-run advise.osds

# cephprocesses.wait exception
salt '*' cephprocesses.check results=True

#################################################################################
# custome role rgw
cat <<EOF >>/srv/pillar/ceph/stack/global.yml
rgw_configurations:
   - rezzz
rgw_init: default-ssl
EOF
MASTER=ses5node1.qalab
salt-run state.orch ceph.stage.1
# add role-rezzz to policy.cfg
cp /srv/salt/ceph/rgw/files/rgw-ssl.j2 /srv/salt/ceph/rgw/files/rezzz.j2
salt-run state.orch ceph.stage.2
salt '*' rgw.configurations
# instead of stage 3:
cp /srv/salt/ceph/configuration/files/rgw-ssl.conf /srv/salt/ceph/configuration/files/rezzz.conf
cat <<EOF > /srv/salt/ceph/configuration/files/ceph.conf.d/rezzz.conf
[client.{{ client }}]
rgw frontends = "civetweb port=443s ssl_certificate=/etc/ceph/rgw.pem"
rgw dns name = {{ fqdn }}
rgw enable usage log = true
EOF
salt $MASTER state.apply ceph.configuration.check
salt $MASTER state.apply ceph.configuration.create
salt $MASTER state.apply ceph.configuration
# instead of stage 4:
salt 'ses5node1*' state.apply ceph.rgw.auth
salt 'ses5node1*' state.apply ceph.rgw.users
salt -I roles:rezzz state.apply ceph.rgw
salt 'ses5node1*' state.apply ceph.monitoring.prometheus.exporters.ceph_rgw_exporter
salt 'ses5node1*' state.apply ceph.rgw.buckets
#################################################################################


# network settings
salt \* pillar.get cluster_network
salt \* pillar.get public_network

# manually change network settings , run stage 2
vi /srv/pillar/ceph/proposals/config/stack/default/ceph/cluster.yml


# one node cluster single node cluster settings - before stage 3
cat <<EOF >> /srv/salt/ceph/configuration/files/ceph.conf.d/global.conf
mon pg warn min per osd = 16
osd pool default size = 2
osd crush chooseleaf type = 0 # failure domain == osd
EOF
