This is a sample app that demonstrates how to use the Twilio Conversations API to create a web chat client that sends/receives text messages to a mobile device. 

This repo is forked from [TwilioDevEd/conversations-demo](https://github.com/TwilioDevEd/conversations-demo/tree/master/).

## Changes

I made the following changes:

- Added a `twilioAccessToken` const for pasting the token in `/src/ConversationsApp.js` line 17 rather than having to paste the token into the `myToken` const on line 73.
- Created scripts in the `/scripts` folder to automate configuration of the demo. 

## Environment Variables

You must create a `.env` file and populate it with the following environment variables, which are provided in the `.env.example` file:

- `TWILIO_ACCOUNT_SID=`\<Your Twilio Account SID from the Twilio Console Dashboard>
- `TWILIO_AUTH_TOKEN=`\<Your Twilio Auth Token from the Twilio Console Dashboard>
- `TWILIO_CONVERSATIONS_PHONE_NUMBER=`\<Your Twilio Phone number in E.164 format (+12065551212)>
- `MOBILE_PHONE_NUMBER=`\<Your Mobile phone number in E.164 format (+12065551212)>
- `MOBILE_NAME=`\<Your name>
- `IDENTITY=`\<The identity or name (e.g. Chat Agent) you want to use for your Chat client>

## Automatic setup scripts

You must install the [Twilio CLI](https://www.twilio.com/docs/twilio-cli/quickstart) and [jq](https://stedolan.github.io/jq/) to run the shell scripts.

To run the scripts:

```bash
cd <project folder>
scripts/batch.sh
```

The batch.sh script  will run the following scipts in order:

- `delete-all-conversations.sh` - deletes all existing conversations to clean up and simplify participant management.
- `create-conversation.sh` - creates a new conversation container.
- `add-mobile-participant.sh` - adds a mobile user and proxy to the conversation.
- `add-chat-partipant.sh` - adds a chat participant to the conversation.
- `generate-token.sh` - generates a token for the chat participant. The TTL is 24 hours before you will need to create a new one.
- `send-message.sh` - creates the first message in the conversation.

Repeat the steps above any time you want to start from a clean slate.

## Running the app

1. Type `npm install` to install the app dependencies. You only have to do this once.
2. After running the scripts above you must copy/paste the token that is generated for the `twilioAccessToken` variable in `src/ConversationsApp.js` line 17.
3. Type `npm start` to start the chat client. You can then send messages from the chat client and your mobile device to have a conversation.

Original ReadMe appears below:

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
