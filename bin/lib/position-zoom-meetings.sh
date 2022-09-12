#!/bin/sh
i3-msg '[title="Zoom Meeting"]' move to workspace "$1"
i3-msg '[title="Zoom$"]' move to workspace "$2"
i3-msg workspace "$2"
i3-msg workspace "$1"
