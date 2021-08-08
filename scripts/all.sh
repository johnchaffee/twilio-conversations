#!/bin/sh

# Load environment variables from .env
# https://stackoverflow.com/a/30969768/179329
set -o allexport; source ../.env; set +o allexport

./delete-conv.sh
./migrate.sh
# ./add-participants.sh