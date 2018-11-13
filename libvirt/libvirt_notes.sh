# add shared folder
## edit guest:

<devices ...>
  <filesystem type='mount' accessmode='passthrough'>
    <source dir='/opt/test'/>
    <target dir='thinkpad'/>
  </filesystem>
</devices>

## on guest:
sudo cat >>/etc/modules <<EOF
loop
virtio
9p
9pnet
9pnet_virtio
EOF

sudo service kmod start
mount thinkpad /home/mstan/thinkpad -t 9p -o trans=virtio
echo "thinkpad /home/mstan/thinkpad            9p             trans=virtio    0       0"| sudo tee -a /etc/fstab

##############################################################################
# network | network name is "default"
# list networks
virsh net-list

# set network to auto-start
virsh net-autostart default

# start a network
virsh net-start default

# check dhcp leases
virsh net-dhcp-leases default

# check ip of a vm
virsh domifaddr vmname

# if not working, install qemu-guest-agent in the VM
virsh domifaddr vmname --source agent --interface eth0
##############################################################################


##############################################################################
# pools
# list pools
virsh pool-list --all

# define new pool by making a xml file : pool_sdg.xml
<pool type='dir'>
  <name>VM-ssd-sdg</name>
  <uuid>a5c05e21-b7c1-476c-9606-b0c6a28a67a3</uuid>
  <source>
  </source>
  <target>
    <path>/VM-ssd-sdg</path>
    <permissions>
      <mode>0755</mode>
      <owner>0</owner>
      <group>0</group>
    </permissions>
  </target>
</pool>
# use pool-define to define a persisten pool,
# instaed of pool-create
virsh pool-define pool_sdg.xml

# setup pool autostart
virsh pool-autostart VM-ssd-sdg

##############################################################################
