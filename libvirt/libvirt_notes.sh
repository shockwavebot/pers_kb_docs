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
