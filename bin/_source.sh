#!/usr/bin/env bash

command=$1

INSTALATION_FACT_FILE=/fact_dir/installed.fact

waitForDindStart () {
  echo 'awaiting for DIND host'

  sleep 5

  until nc -z ${DIND_HOST} ${DIND_PORT}; do
    echo waiting for DIND host ${DIND_HOST}:${DIND_PORT}
    sleep 5
  done
}

isSentryNotInstalled () {
  [ ! -f "$INSTALATION_FACT_FILE" ]
}

installSentry () {
  echo 'starting installation of sentry'
  ./install.sh && touch $INSTALATION_FACT_FILE
}
