#!/bin/sh
set -e
PROJECT_URL="http://www.worldcommunitygrid.org/"
echo "update project $PROJECT_URL"
boinccmd --project $PROJECT_URL update
