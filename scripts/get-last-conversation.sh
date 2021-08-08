#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

echo "=== GET-LAST-CONVERSATION ==="

# Fetch the last conversation and set the variables needed by other functions
CONVERSATION=`twilio api:conversations:v1:conversations:list -o json | jq 'sort_by(.dateCreated) | last'`
echo $CONVERSATION
CONVERSATION_SID=`echo $CONVERSATION | jq .sid | cut -c2-35`
echo "CONVERSATION_SID: $CONVERSATION_SID"
CHAT_SERVICE_SID=`echo $CONVERSATION | jq .chatServiceSid | cut -c2-35`
echo "CHAT_SERVICE_SID: $CHAT_SERVICE_SID"
MESSAGING_SERVICE_SID=`echo $CONVERSATION | jq .messagingServiceSid | cut -c2-35`
echo "MESSAGING_SERVICE_SID: $MESSAGING_SERVICE_SID"
FRIENDLY_NAME=`echo $CONVERSATION | jq .friendlyName`
echo "FRIENDLY_NAME: $FRIENDLY_NAME"

