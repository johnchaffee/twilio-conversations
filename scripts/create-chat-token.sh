#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

echo "=== CREATE-CHAT-TOKEN ==="

# Set variables to share with ./get-last-conversation.sh sub-script
# CHAT_SERVICE_SID=
# . ./get-last-conversation.sh

# Create long-lived (24 hours in seconds) token for chat user 
echo "twilio token:chat"
TOKEN=`twilio token:chat \
--chat-service-sid "$CHAT_SERVICE_SID" \
--identity "$IDENTITY" \
--ttl 86400 \
--profile jc`
echo TOKEN: $TOKEN
