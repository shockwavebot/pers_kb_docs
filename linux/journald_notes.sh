# journald
# systemd-journald.service
# /etc/systemd/journald.conf

# - Kernel log messages, via kmsg
# - Simple system log messages, via the libc syslog(3) call
# - Structured system log messages via the native Journal API, see sd_journal_print(4)
# - Standard output and standard error of service units
# - Audit records, originating from the kernel audit subsystem

https://www.freedesktop.org/software/systemd/man/systemd-journald.service.html
https://unix.stackexchange.com/questions/332274/is-systemd-journald-a-syslog-implementation

# Forward to syslog
sed -i 's/#ForwardToSyslog=yes/ForwardToSyslog=yes/g' /etc/systemd/journald.conf
systemctl restart systemd-journald.service

# ========================================================================================================================
# send syslog to journald
# http://www.rsyslog.com/doc/v8-stable/configuration/modules/omjournal.html
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/s1-interaction_of_rsyslog_and_journal

module(load="omjournal")

template(name="journal" type="list") {
  constant(value="MARKO CAR" outname="MESSAGE")
  property(name="$!event-type" outname="EVENT_TYPE")
}

action(type="omjournal" template="journal")

# ========================================================================================================================

journalctl --since "2015-01-10" --until "2015-01-11 03:00"
journalctl -u nginx.service
journalctl _PID=8088
journalctl -p err -b
journalctl -p info -u ceph-mon@ses5node1.service
journalctl -p info -u ceph-mgr@ses5node1.service --since "2017-11-07 14:00" --until "2017-11-07 14:28"


# ========================================================================================================================
# manually adding log to journald
systemd-cat -t "my_tag" -p info echo "my message to journald" 		# stderr is not captured
echo "my message to journald" | systemd-cat -t "my_tag" -p info
# ========================================================================================================================
# WRITING LOGS TO journald

MY_LOG_FILE=/tmp/my_log_file

# Create a FIFO PIPE
PIPE=/tmp/my_fifo_pipe
mkfifo $PIPE
MY_IDENTIFIER="my_app_name"		# just a label for later searching in journalctl

# Start logging to journal
systemd-cat -t $MY_IDENTIFIER -p info < $PIPE &
exec 3>$PIPE

tail -f $MY_LOG_FILE > $PIPE &

exec 3>&-
#closing file descriptor 3 closes the fifo

# ========================================================================================================================

# using python module to read journald logs
https://www.g-loaded.eu/2016/11/26/how-to-tail-log-entries-through-the-systemd-journal-using-python/
https://tim.siosm.fr/blog/2014/02/24/journald-log-scanner-python/
https://www.freedesktop.org/software/systemd/python-systemd/journal.html#systemd.journal._Reader.has_persistent_files

# basic setup
mkdir -p /var/log/journal
sed -i '/Storage/c\Storage=persistent' /etc/systemd/journald.conf
systemctl restart systemd-journald.service
