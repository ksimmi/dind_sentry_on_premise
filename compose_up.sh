#!/usr/bin/env bash

source .env

dind_compose="docker-compose"

upSentryCompose () {
  export COMMAND=start
  $dind_compose down -t 1;
  $dind_compose up -d
}

awaitForSentryWeb () {
  echo 'awaiting for DIND SentryWeb'

  sleep 5

  until nc -z localhost 9100; do
    echo 'web_1 IMHERE'
    echo waiting for SentryWeb host localhost:9100
    sleep 5
  done
}

getSentryWebDockerId () {
  container_id=$(cat <<'EOF' | docker exec --interactive ${SENTRY_HOST} bash
    sentry_web_container_id=''

    until ! [ -z "$sentry_web_container_id" ]; do
      sentry_web_container_id=$(docker ps | grep sentry_onpremise_web | awk '{print $1}' )
    done

    echo $sentry_web_container_id
EOF
  )
  echo $container_id
}

execCommandOnSentryWeb () {
  command=$1
  container_id=$(getSentryWebDockerId)

  echo '2-nd'

  cat <<EOF | docker exec --interactive ${SENTRY_HOST} bash
    set -xueo pipefail
    echo docker exec -i $container_id sentry $command
    docker exec -i $container_id $command
EOF
}

createSentryWebFirstUser () {
  echo '1-st'
  execCommandOnSentryWeb 'sentry createuser \
    --email ttk@user.ttk \
    --password Passw0rd \
    --superuser
    '
}

upSentryCompose
awaitForSentryWeb
createSentryWebFirstUser