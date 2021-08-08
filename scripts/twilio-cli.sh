#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

# Create a new conversation
# twilio api:conversations:v1:conversations:create \
#   --friendly-name "My First Conversation"

CONVERSATION_SID=`twilio api:conversations:v1:conversations:create --friendly-name "$MOBILE_NAME" | grep "CH" | cut -c1-34`
echo CONVERSATION_SID $CONVERSATION_SID

# Fetch the new conversation
# twilio api:conversations:v1:conversations:fetch \
#   --sid "$CONVERSATION_SID"

CHAT_SERVICE_SID=`twilio api:conversations:v1:conversations:fetch --sid $CONVERSATION_SID | grep "IS" | cut -c1-34`
echo CHAT_SERVICE_SID $CHAT_SERVICE_SID

# Add a Chat participant
twilio api:conversations:v1:conversations:participants:create \
  --conversation-sid "$CONVERSATION_SID" \
  --identity "$CHAT_USER_IDENTITY"

# Add an SMS Participant
  twilio api:conversations:v1:conversations:participants:create \
  --conversation-sid "$CONVERSATION_SID" \
  --messaging-binding.address "$MOBILE_NUMBER" \
  --messaging-binding.proxy-address "$TWILIO_SMS_NUMBER"