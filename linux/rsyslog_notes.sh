# CONFIGURATION FILE 			/etc/rsyslog.conf
# CONFIGURATION DIRECTORY		/etc/rsyslog.d/
# DEAMON PARAMETERS 			/etc/syscofig/syslog

# syslog
# systemctl status rsyslog.service
# http://www.rsyslog.com/doc/
#
# http://shallowsky.com/blog/linux/rsyslog-conf-tutorial.html

######################################################################
# @/etc/rsyslog.conf
local4.=debug -/var/log/local4.debug
local4.=info -/var/log/local4.info
local4.* -/var/log/local4
# service restart
systemctl restart rsyslog.service
# test
logger -p local4.info "Info message 1"
logger -p local4.debug "Debug message 1"
######################################################################

######################################################################
# remote logging to a server
# @server
echo '$ModLoad imtcp
$InputTCPServerRun 514' >> /etc/rsyslog.conf
# firewall rule
iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 514 -j ACCEPT
# restart service
systemctl restart rsyslog.service
# @client
LOG_HOST=ses5node1.qatest
echo "*.* @@${LOG_HOST}:10514" > /etc/rsyslog.d/${LOG_HOST}.conf
systemctl restart rsyslog.service
######################################################################

######################################################################
# Use the following properties in your systemd service unit file:
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=<your program identifier> # without any quote
# Then, assuming your distribution is using rsyslog to manage syslogs, create a file in /etc/rsyslog.d/<new_file>.conf with the following content:
if $programname == '<your program identifier>' then /path/to/log/file.log
######################################################################

# put all logs in one file
$template DynFile,"/var/log/system-%HOSTNAME%.log"
*.*	?DynFile

######################################################################

cat <<EOF >> /etc/rsyslog.conf

module(load="imfile" PollingInterval="10")

input(type="imfile"
      File="/var/log/ceph/ceph.log"
      Tag="ceph"
      Severity="info"
      Facility="local0")

local0.info /var/log/ceph/ceph_rsyslog_redirexted.log

EOF

systemctl restart rsyslog.service

######################################################################

######################################################################
# sending file logs to journal
module(load="imfile" PollingInterval="10")
module(load="omjournal") # output module for journal

input(type="imfile"
      File="/var/log/ceph/test.log"
      Tag="marko"
      Severity="info"
      Facility="local7"
      ruleset="writeToJournal")

ruleset(name="writeToJournal") {
	action(type="omjournal")
}

######################################################################


# CONFIG journal and rsyslog
mkdir -p /var/log/journal
sed -i '/Storage/c\Storage=persistent' /etc/systemd/journald.conf
systemctl restart systemd-journald.service
cat<<EOF >>/tmp/rsyslog.conf
# sending file logs to journal
module(load="imfile" PollingInterval="5")
module(load="omjournal") # output module for journal
# LIST OF FILES
input(type="imfile" File="/var/log/ceph/ceph.log" Tag="ceph" Severity="info" Facility="local7" ruleset="writeToJournal")
input(type="imfile" File="/var/log/zypp/history" Tag="zypp_history" Severity="info" Facility="local7" ruleset="writeToJournal")
input(type="imfile" File="/var/log/zypper.log" Tag="zypper_log" Severity="info" Facility="local7" ruleset="writeToJournal")
#ganesha__input(type="imfile" File="/var/log/ganesha/ganesha.log" Tag="ganesha" Severity="info" Facility="local7" ruleset="writeToJournal")
#openattic__input(type="imfile" File="/var/log/openattic/openattic.log" Tag="openattic" Severity="info" Facility="local7" ruleset="writeToJournal")
#deepsea__input(type="imfile" File="/var/log/deepsea.log" Tag="deepsea" Severity="info" Facility="local7" ruleset="writeToJournal")
#grafana__input(type="imfile" File="/var/log/grafana/grafana.log" Tag="grafana" Severity="info" Facility="local7" ruleset="writeToJournal")
ruleset(name="writeToJournal") {
        action(type="omjournal")
}
EOF
