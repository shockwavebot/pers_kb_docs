# configure secure http for RGW

# generate a self-signed SSL certificate on the Salt master

# ? which IPs to put there? why tu put there rest of the cluster nodes? should I put only mons, or only rgw nodes?
# SUB_ALT_NAME="subjectAltName = IP: 192.168.122.53 IP: 192.168.122.151 IP: 192.168.122.134 IP: 192.168.122.100"
SUB_ALT_NAME="subjectAltName = IP: 192.168.122.134"
sed -i "/^\[ v3_req \]/a\\${SUB_ALT_NAME}" /etc/ssl/openssl.cnf

# Create the key and the certificate using openssl
openssl req -x509 -nodes -days 1095 -newkey rsa:4096 -keyout rgw.key -out /srv/salt/ceph/rgw/cert/rgw.pem

# ses5node1:~ # openssl req -x509 -nodes -days 1095 -newkey rsa:4096 -keyout rgw.key -out /srv/salt/ceph/rgw/cert/rgw.pem
# Generating a 4096 bit RSA private key
# .++
# .....++
# writing new private key to 'rgw.key'
# -----
# You are about to be asked to enter information that will be incorporated
# into your certificate request.
# What you are about to enter is what is called a Distinguished Name or a DN.
# There are quite a few fields but you can leave some blank
# For some fields there will be a default value,
# If you enter '.', the field will be left blank.
# -----
# Country Name (2 letter code) [AU]:cz
# State or Province Name (full name) [Some-State]:.
# Locality Name (eg, city) []:prague
# Organization Name (eg, company) [Internet Widgits Pty Ltd]:suse
# Organizational Unit Name (eg, section) []:qa
# Common Name (e.g. server FQDN or YOUR name) []:sesqa
# Email Address []:.

# Append the key to the certificate file:
cat rgw.key >> /srv/salt/ceph/rgw/cert/rgw.pem

# !!! changing rgw-ssl to rezz role !!!

# add config
cat <<EOF >>/srv/pillar/ceph/stack/global.yml
rgw_configurations:
   - rezzz
rgw_init: default-ssl
EOF

MASTER=ses5node1.qalab

salt-run state.orch ceph.stage.1
# add role-rezzz to policy.cfg
cp /srv/salt/ceph/rgw/files/rgw-ssl.j2 /srv/salt/ceph/rgw/files/rezzz.j2
salt-run state.orch ceph.stage.2
salt '*' rgw.configurations
# instead of stage 3:
cp /srv/salt/ceph/configuration/files/rgw-ssl.conf /srv/salt/ceph/configuration/files/rezzz.conf
cat <<EOF > /srv/salt/ceph/configuration/files/ceph.conf.d/rezzz.conf
[client.{{ client }}]
rgw frontends = "civetweb port=443s ssl_certificate=/etc/ceph/rgw.pem"
rgw dns name = {{ fqdn }}
rgw enable usage log = true
EOF
salt $MASTER state.apply ceph.configuration.check
salt $MASTER state.apply ceph.configuration.create
salt $MASTER state.apply ceph.configuration

salt-run state.orch ceph.stage.4


Comments:
- rgw.pem was not copied to rgw-ssl node, I had to do it manually
- in rgw config for ceph.conf, port is 80, but https will use 443 and this is automatically configured, just maybe it is good idea to put it explicitly to config file
- stage 4 will return 0, even the rgw service is failed, this is due to service start OK, and after few seconds of delay it is failed. This is tricky to fix, and probably some modification would be needed in radosgw service itself


################################################################################
################################################################################
# COMMENTS FROM BUG REPORT


Lastly, instead of the entire Stage 4, you can run the radosgw orchestration.

# salt-run state.orch ceph.stage.radosgw

salt 'ses5node1*' state.apply ceph.rgw.auth
salt 'ses5node1*' state.apply ceph.rgw.users
salt -I roles:rezzz state.apply ceph.rgw
salt 'ses5node1*' state.apply ceph.monitoring.prometheus.exporters.ceph_rgw_exporter
salt 'ses5node1*' state.apply ceph.rgw.buckets

################################################################################
################################################################################
