#!/bin/sh
i3-msg '[title="Zoom Meeting"]' move to workspace "$1"
i3-msg '[title="Zoom$"]' move to workspace "$3"

i3-msg workspace "$3"
i3-msg move workspace to output "$4"
i3-msg workspace "$1"
i3-msg move workspace to output "$2"
