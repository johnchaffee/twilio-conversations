#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

# Create Conversation with Mobile Name
CONVERSATION=`twilio api:conversations:v1:conversations:create --friendly-name "$MOBILE_NAME" | grep "CH"`
echo CONVERSATION $CONVERSATION

CONVERSATION_SID=`echo "$CONVERSATION" | cut -c1-34`
echo CONVERSATION_SID $CONVERSATION_SID

CHAT_SERVICE_ID=`echo "$CONVERSATION" | cut -c37-70`
echo CHAT_SERVICE_ID $CHAT_SERVICE_ID

# Create SMS participant (John mobile)
echo "messaging-binding.address" $MOBILE_NUMBER "messaging-binding.proxy-address" $TWILIO_LANDLINE
twilio api:conversations:v1:conversations:participants:create --conversation-sid="$CONVERSATION_SID" --messaging-binding.address "$MOBILE_NUMBER" --messaging-binding.proxy-address "$TWILIO_LANDLINE"

# Create long-lived (24 hours in seconds) token for zipwhip user 
echo "twilio token:chat"
TOKEN=`twilio token:chat --chat-service-sid "$CHAT_SERVICE_ID" --identity "$ZIPWHIP_USER" --ttl 86400 --profile jc`
echo TOKEN: $TOKEN

# Create zipwhip user chat identity
ZIPWHIP_CHAT_ID=`twilio api:conversations:v1:conversations:participants:create --conversation-sid "$CONVERSATION_SID" --identity "$ZIPWHIP_USER" | grep "MB" | cut -c1-34`
echo ZIPWHIP_CHAT_ID $ZIPWHIP_CHAT_ID
