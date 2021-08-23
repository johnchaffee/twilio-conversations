#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

echo "\033[0;32m=== SEND-MESSAGE ===\033[0m"
CONVERSATION_SID=`twilio api:conversations:v1:conversations:list -o json | jq 'sort_by(.dateCreated) | last | .sid' | cut -c2-35`
echo "CONVERSATION_SID: \033[0;32m$CONVERSATION_SID\033[0m"
echo "IDENTITY: \033[0;32m$IDENTITY\033[0m"
echo "BODY: \033[0;32mHi $MOBILE_NAME! Welcome to my conversation.\033[0m"

# Create Message
twilio api:conversations:v1:conversations:messages:create \
--conversation-sid $CONVERSATION_SID \
--body "Hi $MOBILE_NAME! Welcome to my conversation." \
--author "$IDENTITY"
# -o json | jq
