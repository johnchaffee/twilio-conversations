#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

echo "=== CREATE-CHAT-IDENTITY ==="
CONVERSATION_SID=`twilio api:conversations:v1:conversations:list -o json | jq 'sort_by(.dateCreated) | last | .sid' | cut -c2-35`
echo "CONVERSATION_SID: \033[0;32m$CONVERSATION_SID\033[0m"
echo "IDENTITY: \033[0;32m$IDENTITY\033[0m"

# Create Chat participant
twilio api:conversations:v1:conversations:participants:create \
--conversation-sid "$CONVERSATION_SID" \
--identity "$IDENTITY" \
-o json | jq
