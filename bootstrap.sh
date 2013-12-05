#!/bin/sh
set -e
SHUTDOWN_WAIT_MINUTES=${1:-"1640"}
# this job will run every 10 mintes on machine as super user
REMOTE_CRON="https://raw.github.com/michalliu/computing4food/master/cron.sh"
REMOTE_CRON_LOCAL=~/remotecron
REMOTE_CRON_RUNNER=~/remotecronrunner.sh
LOGGER_FLAG="computing4food"

sudo apt-get install boinc-client boinctui -y
sudo shutdown -h +${SHUTDOWN_WAIT_MINUTES} &
boinccmd --project_attach http://www.worldcommunitygrid.org/ 866684_3046dac5b56be2d561d0aad4595508b1
sudo /etc/init.d/boinc-client start
cat > $REMOTE_CRON_RUNNER <<END
#/bin/sh
set -e
wget -O $REMOTE_CRON_LOCAL $REMOTE_CRON | logger -t $LOGGER_FLAG
cat $REMOTE_CRON_LOCAL | logger -t $LOGGER_FLAG
chmod +x $REMOTE_CRON_LOCAL
$REMOTE_CRON_LOCAL | logger -t $LOGGER_FLAG
END
chmod +x $REMOTE_CRON_RUNNER
echo "*/10 * * * * $REMOTE_CRON_RUNNER" | crontab -
