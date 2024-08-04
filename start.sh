#!/bin/bash

trap 'cleanup' SIGINT

function cleanup() {
  docker-compose down
}

docker-compose build && docker-compose up
