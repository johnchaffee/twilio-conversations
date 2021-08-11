#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

echo "=== START BATCH ==="
./delete-all-conversations.sh
./create-conversation.sh
./add-mobile-participant.sh
./add-chat-participant.sh
./generate-token.sh
./send-message.sh
echo "=== END BATCH ==="
