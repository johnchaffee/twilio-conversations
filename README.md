This repo is forked from [TwilioDevEd/conversations-demo](https://github.com/TwilioDevEd/conversations-demo/tree/master/).

I made the following changes:

- Created a `twilioAccessToken` const in `/src/ConversationsApp.js` line 17 rather than having to paste it the `myToken` const on line 73.
- Created the following scripts in the `/scripts` folder for doing a quick demo. You must run them in the following order:

1. `delete-all-conversations.sh` - deletes all existing conversations to simplify the participant management.
2. `create-conversation.sh` - creates a new conversation container.
3. `add-mobile-participant.sh` - adds a mobile user and proxy to the conversation.
4. `add-chat-partipant.sh` - adds a chat participant to the conversation.
5. `generate-token.sh` - generates a token for the chat participant. The TTL is 24 hours before you will need to create a new one.
6. `send-message.sh` - creates the first message in the conversation.

Note: You can run the `batch.sh` script to batch perform all of the steps above in sequence.

```bash
cd <project folder>
scripts/batch.sh
```

7. After running the scripts above you must copy/paste the token that is generated in step 5 to `src/ConversationsApp.js` line 17.
8. Then type `npm install` followed by `npm start` to start the chat client and begin your conversation.

Note: You must create a `.env` file and populate it with the following environment variables, which are provided in the `.env.example` file:

- `TWILIO_ACCOUNT_SID=`\<Your Twilio Account SID from the Twilio Console Dashboard>
- `TWILIO_AUTH_TOKEN=`\<Your Twilio Auth Token from the Twilio Console Dashboard>
- `TWILIO_CONVERSATIONS_PHONE_NUMBER=`\<Your Twilio Phone number in E.164 format (+12065551212)>
- `MOBILE_PHONE_NUMBER=`\<Your Mobile phone number in E.164 format (+12065551212)>
- `IDENTITY=`\<The identity or name (e.g. Chat Client) you want to use for your Chat client>

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
