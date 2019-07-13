# change the mouse pointer size
gsettings set com.ubuntu.user-interface.desktop cursor-size 40

# install chrome browser
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update
sudo apt-get install -y google-chrome-stable

# passwordless sudo
sudo sed -i '/^\%sudo/c\\%sudo ALL=\(ALL\:ALL\) NOPASSWD\: ALL' /etc/sudoers

# location of background wallpapers
/usr/share/backgrounds/

# bootable usb install
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt update
sudo apt install -y woeusb

# right mouse click on touchpad
sudo apt-get install gnome-tweaks 




