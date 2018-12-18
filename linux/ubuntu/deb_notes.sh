# ubuntu/debian
# https://blog.packagecloud.io/eng/2015/03/30/apt-cheat-sheet/
/etc/apt/sources.list

## list
sudo apt list --installed
sudo dpkg -l

## search
sudo apt-cache search __name__
sudo dpkg -l *__name__*

## pkg info
sudo apt-cache show __pkg_name__

## list dependencies
sudo apt-cache showpkg __pkg_name__

## add repo
wget -q -O- 'https://download.ceph.com/keys/release.asc' | sudo apt-key add - # to add keys
sudo add-apt-repository "deb https://download.ceph.com/debian-luminous $(lsb_release -s -c) main"

## before using new repo, update of indexes needed
sudo apt-get update

## show available versions
sudo apt-cache policy __pkg_name__
sudo apt-cache showpkg __pkg_name__

function _run_script_on_remote_host {
        # USAGE: _run_script_on_remote_host HOST SCRIPT_PATH SCRIPT_OTHER_ARGUMENTS
        # IMPORTANT: To be able to catch non-zero RC:
        #             - need to call explicity exit RC in the script
        #             - or use set -e option
        REMOTE_HOST=$1
        SCRIPT_PATH=$2
        SCRIPT_NAME=${2##*/}
        # LOG_FILE=${BASEDIR}/log/${LOG_DIR}/${SCRIPT_NAME}.log_$(date +%Y_%m_%d_%H_%M_%S)
        LOG_FILE=log_file.log
        shift;shift
        ssh $REMOTE_HOST 'bash -sex' < $SCRIPT_PATH $@ > $LOG_FILE 2>&1
        cat $LOG_FILE >/dev/null
}
