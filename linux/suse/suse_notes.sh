# change the mouse pointer size
gsettings set org.gnome.desktop.interface cursor-size 40

# install Chrome browser
sudo zypper ar http://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome
wget https://dl.google.com/linux/linux_signing_key.pub
sudo rpm --import linux_signing_key.pub
sudo zypper in -y google-chrome-stable
