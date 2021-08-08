#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

echo "=== CREATE-MOBILE-PROXY ==="

# Set variables to share with ./get-last-conversation.sh sub-script
# CONVERSATION_SID=
# . ./get-last-conversation.sh

# Create SMS participant
twilio api:conversations:v1:conversations:participants:create \
--conversation-sid="$CONVERSATION_SID" \
--messaging-binding.address "$MOBILE_NUMBER" \
--messaging-binding.proxy-address "$TWILIO_NUMBER"
