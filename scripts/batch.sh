#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

echo "\033[0;32m=== START BATCH ===\033[0m"
./delete-all-conversations.sh
./create-conversation.sh
./add-mobile-participant.sh
./add-chat-participant.sh
./generate-token.sh
./send-message.sh
echo "\033[0;32m=== END BATCH ===\033[0m"
