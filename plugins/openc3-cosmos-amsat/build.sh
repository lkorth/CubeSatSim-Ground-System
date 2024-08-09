#!/bin/bash

version=${1:-"1.0.0"}

echo "test"
echo "$version"

docker build -t openc3-cosmos-amsat .
docker run -v $(pwd):/openc3-cosmos-amsat -t openc3-cosmos-amsat rake build VERSION=$version
