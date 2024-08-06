FROM debian:bookworm

WORKDIR /home/docker

RUN apt-get update && apt-get install -y \
  ruby

COPY telemetry-bridge.rb .

ENTRYPOINT sleep 30 && ruby telemetry-bridge.rb # wait for OpenC3 to start and be ready
