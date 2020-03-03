#!/usr/bin/env bash

source .env
source ./compose_source.sh

upSentryCompose
awaitForSentryWeb
createSentryWebFirstUser