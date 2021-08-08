I added the scripts folder. How to get it running:

```
# Change to the /scripts directory
cd scripts

# Delete all existing conversations (just to clean things up)
./delete-conv.sh

# Create a new conversation, create a Zipwhip User web chat token
# Add the Zipwhip User web chat client and John's mobile phone as participants
./create-conv.sh

# Copy the token that is ouput and paste into line 71 (`const myToken`) of ``src/ConversationsApp.js`.

# Change to the root directory and run npm start
cd ..
npm start

# You may want to delete conversations when done
cd scripts
./delete-conv.sh

```

You should be able to send messages from web browser to John's mobile.

> Original ReadMe below:

---

# The Demo Conversations App

This is a lightweight application based on [Twilio Conversations](https://www.twilio.com/docs/conversations).

Please follow the directions for the [Twilio Conversations Quickstart](https://www.twilio.com/docs/conversations/quickstart) for a complete demo of this application with both SMS and chat participants.

# Configuring and getting started

This demo requires a Twilio account and a working Conversations Service SID.
You'll need to collect some credentials from the [Twilio Console](https://www.twilio.com/console):
* Your Account SID (`ACXXX`) and Auth Token, both accessible from the [Dashboard](https://twilio.com/console/dashboard)
* Your Account's Conversations Service Sid `ISXXX` SID which is attached to your Conversations Service

# Testing

The demo application can be configured and run in two ways:
* Forking [the demo-conversations-application on CodeSandbox.io](https://codesandbox.io/s/github/TwilioDevEd/conversations-demo) (recommended)
* Cloning this repo and running locally

# Replacing the Access Token

The Conversations API uses an Access Token with a Chat Grant for client-side applications such as this one to authenticate themselves with Conversations Services in your Twilio Account.

In order for your Conversations Application to work, we need to authenticate a Conversations user by retrieving a short-lived token attached to your API Key. The `getToken` function in `ConversationsApp.js` has a placeholder for your chat token.

You can generate a token in a few ways:
* Using the [twilio-cli](https://www.twilio.com/docs/twilio-cli/quickstart) and [twilio token plugin](https://github.com/twilio-labs/plugin-token) (Recommended)
* Using [Twilio Runtime Function](https://www.twilio.com/docs/runtime/functions)

 For the twilio-cli option, run the following command and enter the resulting token into the placeholder:
 
 `twilio token:chat --identity <The test chat username> --chat-service-sid <ISXXX...>`

After generating a token manually, it will expire after a timeout period, so you will need to replace the token. To use this in production software, you would typically create a token endpoint in your back end application that uses your existing user authentication strategy.