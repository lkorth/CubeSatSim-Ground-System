# CubeSatSim Ground System

A [OpenC3 COSMOS](https://github.com/OpenC3/cosmos) ground system for use with the [AMSAT](https://www.amsat.org/)
developed [CubeSatSim](https://github.com/alanbjohnston/CubeSatSim).

## Running

The ground system is run via [Docker Compose](https://docs.docker.com/compose/), you must have
[Docker](https://docs.docker.com/) and Docker Compose installed to run it.

A start script is included in the repo that will ensure images are built, start the entire stack,
and ensure it shuts down cleanly after a Ctrl+C.

    ```bash
    ./start.sh
    ```

Should you wish to run the stack manually, the following commands may be used instead of the
`start.sh` script.

Before the first run, or if any changes have been made to local `Dockerfile`s, the images must
be built before they can be run:

    ```bash
    docker-compose build
    ```

After the images are built, the entire stack can be run:

    ```bash
    docker-compose up
    ```

The ground system can be stopped with a Ctrl+C, but the containers should also be removed
in order to avoid conflicts on the next run. If any container reports errors or crashes, the
first troubleshooting step should be to clean up the containers after they are stopped.

    ```bash
    docker-compose down
    ```

## Setup

In order to support CubeSatSim, the OpenC3 plugin must be installed. See the
[plugin documentation](plugins/openc3-cosmos-amsat/README.md#installing-into-openc3-cosmos) for
how to install the plugin.

## Architecture

The ground system utilizes a configured instance of OpenC3 COSMOS as the ground system and
[FoxTelem](https://github.com/ac2cz/FoxTelem) to decode the RF transmissions from CubeSatSim to feed
telemetry to OpenC3 COSMOS.

## Compatibility

USB device pass through via Docker is utilized to expose the USB SDR to FoxTelem. Device pass through is [not possible
on OSX due to a lack of hypervisor support](https://docs.docker.com/desktop/faqs/general/#can-i-pass-through-a-usb-device-to-a-container).
This has only been used and tested on Linux.

## Hardware

A number of containers with varying resource requirements are run as part of the ground system.
A Raspberry Pi 4 with 4gb of ram is a minimum and a Raspberry Pi 5 with 8gb of ram is prefered.
