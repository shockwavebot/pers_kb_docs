# installing eclipse on ubuntu
# https://websiteforstudents.com/how-to-install-eclipse-oxygen-ide-on-ubuntu-167-04-17-10-18-04/
# installing JDK
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | sudo tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
sudo apt-get update
sudo apt-get install -y oracle-java8-installer
# download eclipse from https://www.eclipse.org/downloads/
tar -xvf ~/Downloads/eclipse-inst-linux64.tar.gz -C ~/Downloads/
# run installer and follow wizzard
cat <<EOF > ~/.local/share/applications/eclipse.desktop
[Desktop Entry]
Name=Eclipse JEE Oxygen
Type=Application
Exec=/home/mstan/eclipse/jee-2018-09/eclipse/eclipse
Terminal=false
Icon=/home/mstan/eclipse/jee-2018-09/eclipse/icon.xpm
Comment=Integrated Development Environment
NoDisplay=false
Categories=Development;IDE;
Name[en]=Eclipse
EOF
