#!/bin/sh
PROJECT_URL="http://www.worldcommunitygrid.org/"
LOGGER_FLAG="computing4food_remote"
logger -t $LOGGER_FLAG "update project"
boinccmd --project $PROJECT_URL update | logger -t $LOGGER_FLAG
