#!/usr/bin/env bash

export COMMAND=install
docker-compose down ; \
  docker-compose up ; \
  docker-compose down