#!/bin/bash

# Eg. "http://jenkins.local:8080/"
URL="$1"
# Eg. "PARAM"
PARAM="$2"
# Eg. "production-job"
JOBS=$3
# Eg. "?MYSQL_HOST=51.13.458.1&DB_NAME=db_production&S3_BUCKET=s3_production"
PARAMS="$4"

USER=$5
PASS=$6

if [ "$1" == ""] && [ "$2" == ""]; then
  echo "Usage: $0 <JENKINS_URL> [PARAM] [QUERY_PARAMETERS]"
  echo "Eg. # $0 'https://jenkins.server.com/' '?MYSQL_HOST=db_host.com&DB_NAME=db_production'"
  exit 0
else
  # Get the Crumb to Pass as Header
  crumb=$(curl -u "user:password" -s 'http://$URL:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')

  if [ "$PARAM" == "PARAM" ] && [ "$3" != "" ]; then
    # Trigger a Parameter Job
    curl -u "$USER:$PASS" -H "$crumb" -X POST  http://$URL/job/$JOBS/buildWithParameters$PARAMS
  else
    # Trigger Common Jobs
    curl -u "$USER:$PASS" -H "$crumb" -X POST http://$URL/job/$JOBS/build?delay=0sec
  fi
fi