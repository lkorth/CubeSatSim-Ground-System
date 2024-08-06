#!/bin/bash

trap 'cleanup' SIGINT

function cleanup() {
  docker-compose down
  docker volume remove cubesatsim-ground-system_foxtelem-db-v
}

docker-compose build && docker-compose up
