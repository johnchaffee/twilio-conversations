#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

# Get all the conversation SIDs, they will be surrounded by quotes
CONVERSATIONS=`twilio api:conversations:v1:conversations:list -o json | jq '.[].sid'`

echo "CONVERSATIONS: \n$CONVERSATIONS"

# Loop through each sid, one per line, remove the surrounding quotes, and delete the conversation
while IFS= read -r line; do
  # echo "LINE: $line"
  SID=`echo $line | cut -c2-35`
  echo "Delete sid: $SID"
  twilio api:conversations:v1:conversations:remove --sid $SID
done <<< "$CONVERSATIONS"