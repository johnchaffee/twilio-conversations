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

# Create pseudo mobile user chat identity (for importing message history)
PSEUDO_MOBILE_CHAT_ID=`twilio api:conversations:v1:conversations:participants:create --conversation-sid "$CONVERSATION_SID" --identity "$MOBILE_NAME" | grep "MB" | cut -c1-34`
echo PSEUDO_MOBILE_CHAT_ID $PSEUDO_MOBILE_CHAT_ID

# Add zipwhip user chat participant
twilio api:conversations:v1:conversations:participants:create --conversation-sid "$CONVERSATION_SID" --identity "$ZIPWHIP_USER"

# # Add Mary Agent participant
# twilio api:conversations:v1:conversations:participants:create --conversation-sid "$CONVERSATION_SID" --identity "mary.chaffee@me.com"

# # Add Fred Agent participant
# twilio api:conversations:v1:conversations:participants:create --conversation-sid "$CONVERSATION_SID" --identity "fred.chaffee@me.com"

# # Create long-lived (24 hours in seconds) token for zipwhip user 
# TOKEN=`twilio token:chat --chat-service-sid "$CHAT_SERVICE_ID" --identity "$ZIPWHIP_USER" --ttl 86400 --profile jc`
# echo TOKEN: $TOKEN

# Import message history
MESSAGES=`curl --location --request POST "https://api.zipwhip.com/conversation/get" --header "Content-Type: application/x-www-form-urlencoded" --data-urlencode "session=$ZIPWHIP_SESSION" --data-urlencode "fingerprint=$FINGERPRINT" --data-urlencode "limit=10" | jq '.response["messages"] | reverse[] | .type + " " + .body' | sed 's/"//g'`

echo "MESSAGES: \n$MESSAGES"

# Loop through each line and create an incoming or outgoing message with the appropriate user
while IFS= read -r line; do
  direction=`echo $line | cut -c1-2`
  # body=`echo $line | cut -c4-`
  body=`echo $line | sed 's/^MO //g' | sed 's/^ZO //g'`
  # echo "LINE: $line"
  # echo "DIRECTION: $direction"
  # echo "BODY: $body"
  if [[ $direction = "MO" ]]
  then
    # echo "INCOMING"
    twilio api:conversations:v1:conversations:messages:create --conversation-sid "$CONVERSATION_SID" --author "$MOBILE_NAME" --body "$body"
    # create incoming message
  else
    # echo "OUTGOING"
    twilio api:conversations:v1:conversations:messages:create --conversation-sid "$CONVERSATION_SID" --author "$ZIPWHIP_USER" --body "$body"
  fi
done <<< "$MESSAGES"

# Remove pseudo user
twilio api:conversations:v1:conversations:participants:remove --conversation-sid "$CONVERSATION_SID" --sid "$PSEUDO_MOBILE_CHAT_ID"

# Create Real SMS participant (John mobile) after message history has been populated
twilio api:conversations:v1:conversations:participants:create --conversation-sid="$CONVERSATION_SID" --messaging-binding.address "$MOBILE_NUMBER" --messaging-binding.proxy-address "$TWILIO_LANDLINE"
