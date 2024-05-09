#!/bin/bash

if [[ "$XDG_SESSION_TYPE" = "wayland" ]]; then
  # TODO
  echo "TODO"
else
  export KDEWM=/usr/bin/i3
fi
