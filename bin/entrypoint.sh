#!/usr/bin/env bash

source _source.sh

command=$1

waitForDindStart

if [ "$command" == "install" ]; then
  ./sentry_install.sh
fi

if [ "$command" == "start" ]; then
  ./sentry_start.sh
fi