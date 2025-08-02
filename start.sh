#!/bin/bash

if ! command -v docker &> /dev/null; then
  echo "Error: Docker is not installed or not in PATH"
  echo "Please install Docker first"
  exit 1
fi

if ! docker info &> /dev/null; then
 echo "Error: Docker daemon is not running"
 echo "Please start Docker daemon"
 exit 1
fi

COMPOSE_CMD=""

if docker compose version &> /dev/null; then
  COMPOSE_CMD="docker compose"
elif command -v docker-compose &> /dev/null; then
  COMPOSE_CMD="docker-compose"
else
  echo "Error: Neither 'docker compose' nor 'docker-compose' is available"
  echo "Please install Docker Compose"
  exit 1
fi

trap 'cleanup' SIGINT

function cleanup() {
  $COMPOSE_CMD down
  docker volume remove cubesatsim-ground-system_foxtelem-db-v
}

$COMPOSE_CMD build && $COMPOSE_CMD up
