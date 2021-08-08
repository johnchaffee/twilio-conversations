#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

echo "=== CREATE-CONVERSATION ==="

# Create Conversation
CONVERSATION=`twilio api:conversations:v1:conversations:create --friendly-name "My Conversation" -o json | jq`
echo CONVERSATION $CONVERSATION
