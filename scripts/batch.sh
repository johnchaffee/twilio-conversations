#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

echo "=== START BATCH ==="
./delete-all-conversations.sh
./create-conversation.sh
./create-mobile-participant.sh
./create-chat-participant.sh
./create-token.sh
./create-message.sh
echo "=== END BATCH ==="
