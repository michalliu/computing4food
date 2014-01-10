#!/bin/bash
set -e
SHUTDOWN_WAIT_MINUTES=${1:-"1640"}
# this job will run every 10 mintes on machine as super user
REMOTE_CRON="https://raw.github.com/michalliu/computing4food/master/cron.sh"
REMOTE_CRON_LOCAL=~/remotecron
REMOTE_CRON_RUNNER=~/remotecronrunner.sh
LOGGER_FLAG="computing4food"

if [[ $CRON_ONLY != 1 ]];then
	sudo apt-get install boinc-client boinctui -y
	sudo shutdown -h +${SHUTDOWN_WAIT_MINUTES} &
	boinccmd --project_attach http://www.worldcommunitygrid.org/ 866684_3046dac5b56be2d561d0aad4595508b1
	sudo /etc/init.d/boinc-client start
fi

cat > $REMOTE_CRON_RUNNER <<END
#/bin/sh
set -e
logger -t $LOGGER_FLAG "Fetch remote job $REMOTE_CRON"
wget -O $REMOTE_CRON_LOCAL -q $REMOTE_CRON
cat $REMOTE_CRON_LOCAL | logger -t $LOGGER_FLAG
logger -t $LOGGER_FLAG "Run remote job"
/bin/sh $REMOTE_CRON_LOCAL | logger -t ${LOGGER_FLAG}_remote
END
/bin/sh $REMOTE_CRON_RUNNER

echo "*/10 * * * * $REMOTE_CRON_RUNNER" | crontab -
