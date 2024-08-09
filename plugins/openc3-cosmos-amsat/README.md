# OpenC3 COSMOS AMSAT Plugin

A [OpenC3 COSMOS](https://github.com/OpenC3/cosmos) plugin for use with the [AMSAT](https://www.amsat.org/)
developed [CubeSatSim](https://github.com/alanbjohnston/CubeSatSim).

This plugin was [generated using the openc3
cli](https://docs.openc3.com/docs/getting-started/gettingstarted#interfacing-with-your-hardware).

## Building

Any changes made to the plugin require a new gem file to be built and installed within OpenC3 for the changes to take effect.
If you have not made any changes to the plugin, continue to the [Installing into OpenC3 COSMOS](#installing-into-openc3-cosmos) section below.

A Docker image is provided to build the plugin without Ruby installed. To build the plugin via
Docker, run the `build.sh` script and optionally pass a version for the build. For the purposes of
testing, the version is arbitrary and can be any value in the format `X.Y.Z`, i.e. `1.0.0`.

```bash
./build.sh
```

or

```bash
./build.sh 1.0.0
```

If you have Ruby and Rake available you can build via

```bash
rake build VERSION=X.Y.Z
```

Note: VERSION is required when building via Rake.

## Installing into OpenC3 COSMOS

This folder contains the latest version of the plugin, if you have not made any changes to the
plugin you can install the `openc3-cosmos-amsat-*.gem` plugin instead of building it first.

1. Go to the OpenC3 Admin Console, Plugins Tab
1. Click the paperclip icon and choose your openc3-cosmos-amsat-*.gem file from your computer (note:
   if you are running OpenC3 or building this plugin on a computer that is different than the
   computer you are using to access OpenC3 in a browser, you will need to copy the gem file to the
   computer you are using the browser on, or download the gem file from this repo on GitHub.)
1. Fill out plugin parameters
1. Click Install

## Upgrading in OpenC3 COSMOS

1. Go to the OpenC3 Admin Console, Plugins Tab
1. If `cosmos-openc3-amsat` shows up in the list of plugins, click on the upgrade button on the
   existing plugin in the list
1. Choose your openc3-cosmos-amsat-*.gem file (the same note about the location of the gem file
   above applies to upgrades as well)
1. Fill out plugin parameters
1. Click Install

## Testing

In order to generate telemetry to work off of without a satellite, the script
[`send_mock_realtime_telemetry_packet.rb`](send_mock_realtime_telemetry_packet.rb) can be run from
the root of the plugin directory to send a realtime telemetry packet to OpenC3 COSMOS. The
script communicates directly with the plugin's TCP interface in OpenC3 COSMOS.

Values in the script can be modified in order to simulate different conditions on the satellite.

```bash
ruby send_mock_realtime_telemetry_packet.rb
```

## Listening Port

This plugin and the [associated docker compose file in this repo](/docker-compose.yml) is setup to write commands and accept
telemetry on port 8081. If this conflicts or you wish to change it, the docker compose,
[telemetry-bridge](/telemetry-bridge/telemetry-bridge.rb) and [plugin definition](plugin.txt) files must all be updated.

The [script](send_mock_realtime_telemetry_packet.rb) also utilizes this port and must be updated if
the port changes as well.

## License

This OpenC3 plugin is released under the MIT License. See [LICENSE.txt](LICENSE.txt)
