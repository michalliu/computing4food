#!/bin/sh
set -e
PROJECT_URL="http://www.worldcommunitygrid.org/"
LOGGER_FLAG="computing4food_remote"
logger -t $LOGGER_FLAG "update project $PROJECT_URL"
boinccmd --project $PROJECT_URL update
