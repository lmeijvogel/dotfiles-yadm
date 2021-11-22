#!/bin/sh
echo 1 $1 >/tmp/pos_zooms
echo 2 $2 >/tmp/pos_zooms
i3-msg '[title="Zoom Meeting"]' move to workspace "$1"
i3-msg '[title="Zoom$"]' move to workspace "$2"
i3-msg workspace "$2"
i3-msg workspace "$1"
