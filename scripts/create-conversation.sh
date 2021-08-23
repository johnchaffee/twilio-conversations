#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

echo "\033[0;32m=== CREATE-CONVERSATION ===\033[0m"
echo "CONVERSATION: \033[0;32m$MOBILE_NAME\033[0m"
CONVERSATION=`twilio api:conversations:v1:conversations:create \
--friendly-name "$MOBILE_NAME" \
-o json`
# echo $CONVERSATION | jq

# CONVERSATION_SID=`echo $CONVERSATION | jq '.[0] .sid' | cut -c2-35`
# echo "CONVERSATION_SID: $CONVERSATION_SID"

# CHAT_SERVICE_SID=`echo $CONVERSATION | jq '.[0] .chatServiceSid'`
# echo "CHAT_SERVICE_SID: $CHAT_SERVICE_SID"

# MESSAGING_SERVICE_SID=`echo $CONVERSATION | jq '.[0] .messagingServiceSid'`
# echo "MESSAGING_SERVICE_SID: $MESSAGING_SERVICE_SID"

# FRIENDLY_NAME=`echo $CONVERSATION | jq '.[0] .friendlyName'`
# echo "FRIENDLY_NAME: $FRIENDLY_NAME"

