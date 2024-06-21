#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
cp ./pulsesecure*.service /etc/systemd/system/
cp ./pulsesecure-netns.sh /usr/local/lib/
mkdir /etc/netns/pulse/
cp ./nsswitch.conf ./resolv.conf /etc/netns/pulse/
systemctl daemon-reload
