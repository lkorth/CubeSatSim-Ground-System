# OpenC3 COSMOS AMSAT Plugin

A [OpenC3 COSMOS](https://github.com/OpenC3/cosmos) plugin for use with the [AMSAT](https://www.amsat.org/)
developed [CubeSatSim](https://github.com/alanbjohnston/CubeSatSim).

This plugin was [generated using the openc3
cli](https://docs.openc3.com/docs/getting-started/gettingstarted#interfacing-with-your-hardware).

## Listening Port

This plugin and the [associated docker compose file in this repo](/docker-compose.yml) is setup to write commands and accept
telemetry on port 8081. If this conflicts or you wish to change it, the docker compose,
[telemetry-bridge](/telemetry-bridge/telemetry-bridge.rb) and [plugin definition](plugin.txt) files must all be updated.

The [script](send_mock_realtime_telemetry_packet.rb) also utilizes this port and must be updated if
the port changes as well.

## Building

1. `rake build VERSION=X.Y.Z`
   - VERSION is required
   - gem file will be built locally

## Installing into OpenC3 COSMOS

1. Go to the OpenC3 Admin Console, Plugins Tab
1. Click the paperclip icon and choose your plugin.gem file
1. Fill out plugin parameters
1. Click Install

## Upgrading in OpenC3 COSMOS

1. Go to the OpenC3 Admin Console, Plugins Tab
1. If `cosmos-openc3-amsat` shows up in the list of plugins, click on the upgrade button on the
   existing plugin in the list
1. Choose your plugin.gem file
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

## License

This OpenC3 plugin is released under the MIT License. See [LICENSE.txt](LICENSE.txt)
