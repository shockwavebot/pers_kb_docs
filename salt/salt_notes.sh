salt-master: 192.168.100.217
salt-minion: 192.168.100.200

# opensuse repos
http://download.opensuse.org/repositories/systemsmanagement:/saltstack/openSUSE_Leap_42.1/systemsmanagement:saltstack.repo
http://download.opensuse.org/distribution/leap/42.2/repo/oss/

# iptables
iptables -A INPUT -m state --state new -m tcp –dport 4505 -j ACCEPT
iptables -A INPUT -m state --state new -m tcp –dport 4506 -j ACCEPT

/etc/salt/pki/master/minions 		# location of minion key
salt-key # use to manage minion keys 
salt-key --list-all 
salt-key --accept-all 

# locations 
/srv/salt/_modules  # location of the custom modules 

salt 'minion_name' test.ping
salt 'minion_name' sys.list_functions test
salt 'minion_name' sys.doc

# running jobs in background
salt --async 'minion.fqdn' pkg.upgrade
salt-run jobs.active 
salt-run jobs.print_job __job_id__

salt 'minion.fqdn' saltutil.term_job __job_id__ # SIGTERM 15
salt 'minion.fqdn' saltutil.kill_job __job_id__ # SIGKILL 9

# running scripts on master
salt-run 
salt-run jobs.list_jobs

# MASTERLESS execution:
salt-call --local 
salt-call test.version				# call salt command directly from minion

# GRAINS
salt '*' grains.ls
salt '*' grains.items
salt '*' grains.item os_family 
salt '*' grains.setval training-server True 		# SETTING THE VALUE OF GRAIN, located in /etc/salt/grains
salt '*' pkg.info_installed apache2 attr=version

salt \* grains.item domain
salt \* grains.item localhost

# TARGETING GRAINS
salt --grain 'os_family:Debian' test.ping

# Compound targeting
salt -C '*minion and G@os:Ubuntu and not L@yourminion,theirminion' test.ping
salt -C 'I@roles:ganesha' cmd.run

salt master.suse pkg.install apache2 
salt '*' service.status apache2

# execute a command on a remote system
salt '*' cmd.run 'cat /etc/salt/grains'
salt '*' cmd.run_all 'cat /etc/salt/grains' 		# run_all returns PID, stderr and RC
salt --out=yaml '*' cmd.run_all 'echo test'			# --out=yaml gives yaml output format

# distribute/copy file from master to minion
salt-cp '*' '/etc/ceph/ceph.conf' '/etc/ceph/'

salt-call state.apply ceph.purge
salt-call grains.item fqdn --out yaml|grep fqdn|awk -F ':' '{print $2}') # get the local fqdn 

# USEFUL modules.functions
user.add
pkg.install 
pkg.remove
pkg.version
pkg.list_pkgs
service.restart
service.enabled ceph-radosgw@
status.diskusage

# CREATE A CUSTOM MODULE 
# buildin example
/usr/lib/python2.7/site-packages/salt/modules/

# deepsee example
mkdir -p /srv/salt/_modules/;cd /srv/salt/_modules/
vi custom_module_name.py

# write the Python code:
def users_as_csv():
    '''
    Retrieve the users from a minion, formatted as comma-separated-values (CSV)

    CLI Example:

    .. code-block:: bash
        salt '*' customuser.users_as_csv
    '''
    user_list = __salt__['user.list_users']()
    csv_list = ','.join(user_list)
    return csv_list

# sync custome module with all of minions
sudo salt '*' saltutil.sync_all

# refresh pillar data
salt '*' saltutil.refresh_pillar
------------------------------------
# The highstate (/srv/salt/top.sls)
Example of /srv/salt/top.sls:
base:
  '*minion':
    - apache
  'os_family:debian':
    - match: grain
    - users_and_ssh

sudo salt '*' state.highstate
------------------------------------

###############################
# salt state files /srv/salt/
# /srv/salt/apache.sls:
install_apache:
  pkg.installed:
    - name: apache2

make sure is up and running:
  service.running:
    - name: apache2
    - enable: True 

salt \* state.sls apache
###############################

###############################
## SALT_SSH : agentless salt ##
zypper in -y salt-ssh
echo "
vutra2:
  host: 192.168.100.140
  user: root" >> /etc/salt/roster

salt-ssh -i vutra2 --passwd susetesting cmd.run 'tail -n 3 /etc/hosts'
###############################


# see the job history on master node:
salt-run jobs.list_jobs
salt-run jobs.active
salt \* saltutil.term_job
salt \* saltutil.kill_job

# create and apply states: 
1. create sls init file:    /srv/salt/apache/init.sls
2. create top file:         /srv/salt/top.sls
3. apply state:             salt \* state.apply apache.init


########################
# SALT RUNNER 
########################
salt-run state.orch ceph.stage.2 # orchestration path: /srv/salt/ceph
# to get help use salt:
salt ses5node1.qatest sys.list_functions state 

# increase verbosity 
--log-level=debug 

##################
INSTALL centos
##################
yum install salt-minion

[saltstack-repo]
name=SaltStack repo for Red Hat Enterprise Linux $releasever
baseurl=https://repo.saltstack.com/yum/redhat/$releasever/$basearch/latest
enabled=1
gpgcheck=1
gpgkey=https://repo.saltstack.com/yum/redhat/$releasever/$basearch/latest/SALTSTACK-GPG-KEY.pub
       https://repo.saltstack.com/yum/redhat/$releasever/$basearch/latest/base/RPM-GPG-KEY-CentOS-7

# to run module from a salt state file 
{% for id in salt.saltutil.runner('rescinded.ids', cluster='ceph') %}
drain osd.{{ id }}:
  module.run:
    - name: osd.zero_weight
    - id: {{ id }}


###########################################
# SALT TRAINING
###########################################
salt cloud - moze da radi i provisioning u cloudu 
salt ssh - za install miniona 

/etc/salt/minion_id #

# modules
__virtualname__ # important - salt name of the module 
def __virtual__ (): # defines if module will be loaded 

# get nested grain key 
salt-call grains.get key1:nested_key

salt-run manage.up  # systems which are up 
salt-run manage.down 

salt [target] sys.list_runner_functions 

# getting more output  
-l debug

# *** TIP: probaj da nedjes module and function rather than cmd.run, example is JSON output ***

# salt states
hosts_file:
  file.managed:
    - name: /etc/hosts 
    - contents: | 
      127.0.0.1 localhost

sync mod_status.conf:
  file.managed:
    - name: /etc/apache2/mods-enabled/mod_status.conf
    - source: salt://mod_status.conf
    - user: root
    - group: root
    - mode: 600
  
salt [target] sys.list_state_modules
salt [target] sys.list_state_functions # to list names of functions for state file 
salt [target] state.apply name_of_state_file

salt [target] state.show_sls state_name # checking syntax of state file 
salt [target] state.sls state_name test=True # dry run of state # or use state.apply 
salt [target] state.show_highstate # checking the highstate  

onchanges - only on change will do action 
watch - on any change, it will do action *recommended 

use - using block as template - saving typing 

# Jinja - dynamic states 
{{ set var = 'value' }}
{{ grains.os }}
{{ sls }} # file name 
{{ sls_path }} # path of the sls  
# macro - for writing functions 

# saltstack formulas - already writen states fro common use cases 

###########################################


# remove minion 
salt-key -d minion_name















