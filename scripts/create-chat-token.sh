#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

echo "=== CREATE-CHAT-TOKEN ==="
CHAT_SERVICE_SID=`twilio api:conversations:v1:conversations:list -o json | jq 'sort_by(.dateCreated) | last | .chatServiceSid' | cut -c2-35`
echo "CHAT_SERVICE_SID: \033[0;32m$CHAT_SERVICE_SID\033[0m"
echo "IDENTITY: \033[0;32m$IDENTITY\033[0m"

# Create long-lived (24 hours in seconds) token for chat user 
TOKEN=`twilio token:chat \
--chat-service-sid "$CHAT_SERVICE_SID" \
--identity "$IDENTITY" \
--ttl 86400 \
--profile jc \
-o json`

echo $TOKEN | jq

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

