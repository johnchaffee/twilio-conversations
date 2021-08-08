#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

# Get last conversation
CONVERSATION=`twilio api:conversations:v1:conversations:list -o json | jq 'sort_by(.dateCreated) | last'`
echo CONVERSATION $CONVERSATION

# CONVERSATION_SID=`echo "$CONVERSATION" | cut -c1-34`
CONVERSATION_SID=`echo "$CONVERSATION" | grep "sid" | cut -c11-44`
echo CONVERSATION_SID $CONVERSATION_SID

# CHAT_SERVICE_ID=`echo "$CONVERSATION" | cut -c37-70`
CHAT_SERVICE_ID=`echo "$CONVERSATION" | grep "chatServiceSid" | cut -c22-55`
echo CHAT_SERVICE_ID $CHAT_SERVICE_ID

# # Create SMS participant (John mobile)
# twilio api:conversations:v1:conversations:participants:create --conversation-sid="$CONVERSATION_SID" --messaging-binding.address "$MOBILE_NUMBER" --messaging-binding.proxy-address "$TWILIO_LANDLINE"

# # Create long-lived (24 hours in seconds) token for web agent
# TOKEN=`twilio token:chat --chat-service-sid "$CHAT_SERVICE_ID" --identity "Web Agent" --ttl 86400 --profile jc`
# echo TOKEN: $TOKEN

# Add Web Agent participant
twilio api:conversations:v1:conversations:participants:create --conversation-sid "$CONVERSATION_SID" --identity "Web Agent"

# Add Mary Agent participant
twilio api:conversations:v1:conversations:participants:create --conversation-sid "$CONVERSATION_SID" --identity "mary.chaffee@me.com"

# Add Fred Agent participant
twilio api:conversations:v1:conversations:participants:create --conversation-sid "$CONVERSATION_SID" --identity "fred.chaffee@me.com"