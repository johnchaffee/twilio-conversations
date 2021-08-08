#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

echo "=== CREATE-CHAT-IDENTITY ==="

# Set variables to share with ./get-last-conversation.sh sub-script
# CONVERSATION_SID=
# . ./get-last-conversation.sh

# Create Chat participant
twilio api:conversations:v1:conversations:participants:create \
--conversation-sid "$CONVERSATION_SID" \
--identity "$IDENTITY"
