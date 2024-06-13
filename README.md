# CubeSatSim Ground System

A [OpenC3 COSMOS](https://github.com/OpenC3/cosmos) ground system for use with the [AMSAT](https://www.amsat.org/)
developed [CubeSatSim](https://github.com/alanbjohnston/CubeSatSim).

## Running

The ground system is run via [Docker Compose](https://docs.docker.com/compose/), you must have
[Docker](https://docs.docker.com/) and Docker Compose installed to run it.

```bash
docker-compose up
```

## Architecture

The ground system utilizes a configured instance of OpenC3 COSMOS as the ground system and
[FoxTelem](https://github.com/ac2cz/FoxTelem) to decode the RF transmissions from CubeSatSim to feed
telemetry to OpenC3 COSMOS.
