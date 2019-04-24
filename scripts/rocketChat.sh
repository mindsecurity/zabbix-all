#!/bin/bash

URL='https://server.com/hooks/<TOKENS>'
LOGFILE="/var/log/zabbix/zabbix-rocketChat.log"
DASHBOARD='https://dashboard.server.com'
USERNAME='Zabbix'

TO="$1"
SUBJECT="$2"
MESSAGE="$3"


if [[ "$SUBJECT" == *"OK"* ]]; then
  COLOR="#00ff33"
  EMOJI=':white_check_mark:'
elif [[ "$SUBJECT" == *"PROBLEM"* ]]; then
  COLOR="#ff2a00"
  EMOJI=':bangbang:'
fi
	
PAYLOAD='{ "icon_emoji": "'${EMOJI}'", "text": "**'${SUBJECT}'**", "attachments": [{ "title_link": "'{$DASHBOARD}'", "text": "'${MESSAGE}'", "color": "'${COLOR}'" }]}'

curl -X POST -H 'Content-Type: application/json' --data "${PAYLOAD}" $URL
echo "curl -X POST -H 'Content-Type: application/json' --data "${PAYLOAD}" $URL" 2>>${LOGFILE} 2>&1
