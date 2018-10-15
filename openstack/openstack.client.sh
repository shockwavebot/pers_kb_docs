#openstack client
pip install python-openstackclient

# get the file from the openstack
export OS_AUTH_URL=https://engcloud.prv.suse.net:5000/v3
export OS_PROJECT_ID=a604e143bfcf4a32a4e9864f6c2a19ab
export OS_PROJECT_NAME="ses-qa"
export OS_USER_DOMAIN_NAME="ldap_users"
if [ -z "$OS_USER_DOMAIN_NAME" ]; then unset OS_USER_DOMAIN_NAME; fi
unset OS_TENANT_ID
unset OS_TENANT_NAME
export OS_USERNAME="mstanojlovic"
export OS_PASSWORD=""
export OS_REGION_NAME="CustomRegion"
if [ -z "$OS_REGION_NAME" ]; then unset OS_REGION_NAME; fi
export OS_INTERFACE=public
export OS_IDENTITY_API_VERSION=3
export OS_CACERT=/home/qatest/SUSE_Trust_Root.pem # this is copied from /etc/ssl/certs/SUSE_Trust_Root.pem


openstack image create --public --disk-format qcow2 --container-format bare --file ecp_sles12sp3.qcow2 SLES12SP3_MSTAN # not authorized to make image public
openstack image create --private --disk-format qcow2 --container-format bare --file ecp_sles12sp3.qcow2 SLES12SP3_MSTAN

# list all available server instances
openstack server list

# show server deatils
openstack server show srv_name
