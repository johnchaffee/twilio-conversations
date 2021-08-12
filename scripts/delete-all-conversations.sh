#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

echo "\033[0;32m=== DELETE-ALL-CONVERSATIONS ===\033[0m"

# Get all the conversation SIDs, they will be surrounded by quotes
CONVERSATIONS=`twilio api:conversations:v1:conversations:list -o json | jq '.[].sid' | cut -c2-35`

echo "CONVERSATIONS: \n\033[0;32m$CONVERSATIONS\033[0m"

# Loop through each conversation sid, one per line, and delete the conversation
while IFS= read -r line; do
  # echo "LINE: $line"
  echo "DELETE: \033[0;32m$line\033[0m"
  twilio api:conversations:v1:conversations:remove --sid $line
done <<< "$CONVERSATIONS"
