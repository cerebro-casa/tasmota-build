#!/bin/bash

set -e

if [ ! -d /src/patch/${1} ]; then
    echo "Patches not found for ${1}"
    exit 0
fi
if [ -d /share/${1} ]; then
    echo "Existing files for ${1} will be overridden!"
fi
echo "Building Tasmota ${1}"
git clone -b ${1} https://github.com/arendst/Tasmota.git /src/tasmota
rm -rf /share/${1}
mkdir -p /share/${1}/src
mkdir -p /share/${1}/bin
cp -R /src/patch/${1}/* /share/${1}/src/
cp -R /src/patch/${1}/* /src/tasmota/
git -C /src/tasmota rev-parse HEAD > /share/${1}/bin/commit.txt
cd /src/tasmota; pio run -j 10 
cp .pioenvs/tasmota/firmware.bin /share/${1}/bin/tasmota.bin
cp .pioenvs/tasmota-minimal/firmware.bin /share/${1}/bin/tasmota-minimal.bin
#gzip -9 -k --rsyncable /share/${1}/bin/tasmota.bin
#gzip -9 -k --rsyncable /share/${1}/bin/tasmota-minimal.bin
echo "Completed.  Firmware listing follows..."
ls -al /share/${1}/bin/