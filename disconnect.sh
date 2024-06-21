#!/usr/bin/env bash
set -euo pipefail

pkill -x pulseUI || true
sudo systemctl stop pulsesecure.service pulsesecure-netns.service
