#!/bin/bash

Xvfb :0 -screen 0 1024x768x24 &

export DISPLAY=:0

cd /opt/grafana/bin

./grafana-cli install grafana-pie-chart-panel

./grafana-server
