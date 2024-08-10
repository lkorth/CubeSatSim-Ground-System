# FoxTelem

The ground system utilizes [FoxTelem](https://github.com/ac2cz/FoxTelem) to decode the RF transmissions
from CubeSatSim.

In order to run FoxTelem headless and automatically a Docker image has been created that includes
pre-configured configuration files. Settings changes may be made by modifying [FoxTelem.properties](FoxTelem.properties).

## Building

This Docker image is built automatically as part of the Docker Compose stack, however should you
wish to test modifications to it, it can be built via:

```bash
docker build -t foxtelem .
```

Note: a new image must be built after every change.

## Running

Once built, the image can be run standalone via:

```bash
docker run -p 5901:5901 --device /dev/bus/usb:/dev/bus/usb -t foxtelem
```

FoxTelem will automatically start running when the container starts.

## Viewing FoxTelem UI

When running as a standalone Docker image or via the Docker Compose stack FoxTelem can be viewed and interacted
with via UI by connecting a VNC client to port 5901. The password is `majortom`.

## Updating configuration

If you wish to update the default configuration used for FoxTelem in this repo, the configuration
can be volumized so that changes in the FoxTelem UI are written to the `FoxTelem.properties` file in
the repo to be commited for future use.

```bash
docker run -p 5901:5901 --device /dev/bus/usb:/dev/bus/usb --volume $(pwd)/FoxTelem.properties:/root/.FoxTelem/FoxTelem.properties -t foxtelem
```
