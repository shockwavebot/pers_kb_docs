# change the mouse pointer size
gsettings set org.gnome.desktop.interface cursor-size 40

# install Chrome browser
sudo zypper ar http://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome
wget https://dl.google.com/linux/linux_signing_key.pub
sudo rpm --import linux_signing_key.pub
sudo zypper in -y google-chrome-stable

# -bash: ping: command not found
sudo zypper install -y iputils

# libvirt cd as repos
zypper ar 'cd:///?devices=/dev/disk/by-id/scsi-0QEMU_QEMU_CD-ROM_drive-scsi0-0-0-1' sle

# add repo as iso
iso_path=/tmp/SLE-15-SP1-Packages-x86_64-Alpha3-DVD1.iso
repo_name=sle
zypper ar -c -f "iso:/?iso=$iso_path" $repo_name
