# OpenC3 COSMOS AMSAT Plugin

A [OpenC3 COSMOS](https://github.com/OpenC3/cosmos) plugin for use with the [AMSAT](https://www.amsat.org/)
developed [CubeSatSim](https://github.com/alanbjohnston/CubeSatSim).

This plugin was [generated using the openc3
cli](https://docs.openc3.com/docs/getting-started/gettingstarted#interfacing-with-your-hardware).

## Listening Port

This plugin and the [associated docker compose file in this repo](/docker-compose.yml) is setup to write commands and accept
telemetry on port 8081. If this conflicts or you wish to change it, the docker compose and [plugin
definition](plugin.txt) files must both be updated.

## Building

1. `rake build VERSION=X.Y.Z`
   - VERSION is required
   - gem file will be built locally

## Installing into OpenC3 COSMOS

1. Go to the OpenC3 Admin Tool, Plugins Tab
1. Click the paperclip icon and choose your plugin.gem file
1. Fill out plugin parameters
1. Click Install

## License

This OpenC3 plugin is released under the MIT License. See [LICENSE.txt](LICENSE.txt)
