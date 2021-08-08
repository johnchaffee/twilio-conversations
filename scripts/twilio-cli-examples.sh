#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

# Add custom attribute to John Mobile
twilio api:conversations:v1:conversations:participants:update \
--conversation-sid CHacaf97a503b54b0c9eff9e3bab740bd8 \
--sid MBca522014e2214a9b8e80a9f40b3f78f9 \
--attributes '{"name": "John Mobile","favoriteColor": "blue"}'
SID                                 Messaging Binding                                                     
MB948f8a5e12f04256b8c2bb23e897381b  {"proxy_address":"+12068231284","type":"sms","address":"+12063996576"}

twilio api:conversations:v1:conversations:participants:update \
--conversation-sid CHacaf97a503b54b0c9eff9e3bab740bd8 \
--sid MBca522014e2214a9b8e80a9f40b3f78f9 \
--attributes '{"favoriteColor":"green"}'


# Fetch participant info
twilio api:conversations:v1:conversations:participants:fetch \
--conversation-sid CHacaf97a503b54b0c9eff9e3bab740bd8 \
--sid MBca522014e2214a9b8e80a9f40b3f78f9
SID                                 Messaging Binding                                                     
MB948f8a5e12f04256b8c2bb23e897381b  {"proxy_address":"+12068231284","type":"sms","address":"+12063996576"}

# Fetch participant info as json
twilio api:conversations:v1:conversations:participants:fetch \
--conversation-sid CHacaf97a503b54b0c9eff9e3bab740bd8 \
--sid MBca522014e2214a9b8e80a9f40b3f78f9 \
-o json
[
  {
    "accountSid": "ACe674d877011b71537aec97f4e3745338",
    "attributes": "{\"name\": \"John Mobile\",\"favoriteColor\": \"blue\"}",
    "conversationSid": "CHacaf97a503b54b0c9eff9e3bab740bd8",
    "dateCreated": "2021-05-28T03:53:27.000Z",
    "dateUpdated": "2021-05-28T04:55:31.000Z",
    "identity": null,
    "lastReadMessageIndex": null,
    "lastReadTimestamp": null,
    "messagingBinding": {
      "proxy_address": "+12068231284",
      "type": "sms",
      "address": "+14259222865"
    },
    "roleSid": "RLbb15ba37dcc84bdd86aee81e2f870231",
    "sid": "MBca522014e2214a9b8e80a9f40b3f78f9",
    "url": "https://conversations.twilio.com/v1/Conversations/CHacaf97a503b54b0c9eff9e3bab740bd8/Participants/MBca522014e2214a9b8e80a9f40b3f78f9"
  }
]
# Output JSON with -o json

twilio api:conversations:v1:conversations:list -o json

# Delete conversation

twilio api:conversations:v1:conversations:remove --sid CH8167c33731a448cfb8b035631831c1b7

# JQ QUERIES
# As objects
curl --location --request POST 'https://api.zipwhip.com/conversation/get' --header 'Content-Type: application/x-www-form-urlencoded' --data-urlencode 'session=40c85017-0973-41c6-b16e-79284a993f1e:377265507' --data-urlencode 'fingerprint=1514465037' --data-urlencode 'limit=2' | jq '.response["messages"][] | {body: .body, type: .type}'

# As objects in an Array
curl --location --request POST 'https://api.zipwhip.com/conversation/get' --header 'Content-Type: application/x-www-form-urlencoded' --data-urlencode 'session=40c85017-0973-41c6-b16e-79284a993f1e:377265507' --data-urlencode 'fingerprint=1514465037' --data-urlencode 'limit=2' | jq '[.response["messages"][] | {body: .body, type: .type}]'

# As objects in a compact -c Array
curl --location --request POST 'https://api.zipwhip.com/conversation/get' --header 'Content-Type: application/x-www-form-urlencoded' --data-urlencode 'session=40c85017-0973-41c6-b16e-79284a993f1e:377265507' --data-urlencode 'fingerprint=1514465037' --data-urlencode 'limit=2' | jq -c '[.response["messages"][] | {body: .body, type: .type}]'

# Export as plain text
curl --location --request POST 'https://api.zipwhip.com/conversation/get' --header 'Content-Type: application/x-www-form-urlencoded' --data-urlencode 'session=40c85017-0973-41c6-b16e-79284a993f1e:377265507' --data-urlencode 'fingerprint=1514465037' --data-urlencode 'limit=2' | jq '.response["messages"][] | .type + " " + .body'

# Run if then statement
MESSAGES=`curl --location --request POST 'https://api.zipwhip.com/conversation/get' --header 'Content-Type: application/x-www-form-urlencoded' --data-urlencode 'session=40c85017-0973-41c6-b16e-79284a993f1e:377265507' --data-urlencode 'fingerprint=1514465037' --data-urlencode 'limit=10' | jq '.response["messages"][] | if .type == "MO" then "MO " + .body else "ZO " + .body end' | sed 's/"//g'`
