#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

echo "=== START BATCH ==="

./delete-all-conversations.sh
./create-conversation.sh

# Set variables to be shared with sub-sripts
CONVERSATION_SID=
CHAT_SERVICE_SID=
MESSAGING_SERVICE_SID=
FRIENDLY_NAME=

# Launch subscripts with leading . to pass variables
. ./get-last-conversation.sh
. ./create-mobile-proxy.sh
. ./create-chat-identity.sh
. ./create-chat-token.sh

echo "=== END BATCH ==="
