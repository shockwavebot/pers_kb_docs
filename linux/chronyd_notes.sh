# install chrony
zypper in -y chrony # suse

# config file
vi /etc/chrony.conf

# after starting, check sources
chronyc -a sources

# check tracking
chronyc -a tracking
