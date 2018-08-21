# IMPORTANT: CREATE A TEMPLATE VM IMAGE 
# and *** KEEP IT UPDATED ***
# use autoyast for this 

# *** edit autoyast file, add ssh public key to authorized_keys 
# *** edit autoyast file, add repos 
# *** edit autoyast file, install pkgs and scripts 

# SLES12SP3 image for cloud/terraform 
#--network type=direct,source=eth0,source_mode=bridge,model=virtio \
virt-install \
--name sles12sp3_tf_img \
--memory 2048 \
--disk path=/VM-disk-f/sles12sp3_tf_img.qcow2,size=20 \
--vcpus 2 \
--network network=default,model=virtio \
--os-type linux \
--noautoconsole \
--os-variant sles12sp3 \
--graphics vnc \
--location /var/lib/libvirt/images/SLE-12-SP3-Server-DVD-x86_64-GM-DVD1.iso \
--initrd-inject=/VM-disk-f/autoyast_SLES12SP3_for_cloud_image.xml \
--extra-args kernel_args="console=/dev/ttyS0 autoyast=file://VM-disk-f/autoyast_SLES12SP3_for_cloud_image.xml"

# install terraform @ SLES
# go to https://www.terraform.io/downloads.html
# download pkg  (0.11.3)
wget -P /tmp/ https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip
unzip -d /usr/local/bin/ /tmp/terraform_0.11.3_linux_amd64.zip

## install go
wget -P /tmp/ https://dl.google.com/go/go1.10.linux-amd64.tar.gz
tar -C /usr/local -xzf /tmp/go1.10.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

# install libvirt provider 
DISTRO=openSUSE_Leap_42.3
zypper addrepo http://download.opensuse.org/repositories/Virtualization:containers/$DISTRO/Virtualization:containers.repo
zypper refresh
zypper install terraform-provider-libvirt

mkdir -p ~/.terraform.d/plugins
mv /usr/local/bin/terraform-provider-libvirt ~/.terraform.d/plugins/

# create a project DIR
mkdir -p /terraform/projects/ses

#####################################################################
# create a file (BASIC EXAMPLE)
#####################################################################
provider "libvirt" {
    uri = "qemu:///system"
}

# qcow2 image from file
resource "libvirt_volume" "sles12sp3" {
  name = "sles12sp3-qcow2"
  source = "/VM/sles12sp3_tf_img_orig.qcow2"
  pool = "VM"
}
# volume with qcow2 backing storage
resource "libvirt_volume" "base" {
  name = "base-vol-sle"
  base_volume_id = "${libvirt_volume.sles12sp3.id}"
  pool = "VM"
}
# domain using qcow2-backed volume
resource "libvirt_domain" "sle-tf-vm" {
  name = "sle-tf-vm"
  memory = "1024"
  vcpu = 1
  network_interface {
    network_name = "vnet1"
  }
  disk {
    volume_id = "${libvirt_volume.base.id}"
  }
  graphics {
    type = "spice"
    listen_type = "address"
    autoport = "yes"
  }
  console {
    type = "pty"
    target_type = "serial"
    target_port = 0
  }
}
#####################################################################

# initiate terraform directory 
terraform init
terraform apply -auto-approve 
terraform destroy 

