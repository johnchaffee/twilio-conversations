#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

echo "=== CREATE-CONVERSATION ==="
CONVERSATION=`twilio api:conversations:v1:conversations:create --friendly-name "My Conversation" -o json`
echo $CONVERSATION | jq

# CONVERSATION_SID=`echo $CONVERSATION | jq '.[0] .sid' | cut -c2-35`
# echo "CONVERSATION_SID: $CONVERSATION_SID"

# CHAT_SERVICE_SID=`echo $CONVERSATION | jq '.[0] .chatServiceSid'`
# echo "CHAT_SERVICE_SID: $CHAT_SERVICE_SID"

# MESSAGING_SERVICE_SID=`echo $CONVERSATION | jq '.[0] .messagingServiceSid'`
# echo "MESSAGING_SERVICE_SID: $MESSAGING_SERVICE_SID"

# FRIENDLY_NAME=`echo $CONVERSATION | jq '.[0] .friendlyName'`
# echo "FRIENDLY_NAME: $FRIENDLY_NAME"

