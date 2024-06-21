#!/usr/bin/env bash
set -euo pipefail

sudo systemctl start pulsesecure.service
/opt/pulsesecure/bin/pulseUI &
sudo sh -c 'until ip -n pulse address show tun0 &> /dev/null; do sleep 1; done'
pkill -x pulseUI
