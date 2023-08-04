#!/bin/bash

# See https://unix.stackexchange.com/questions/132308/changing-kdes-mouse-theme-and-buttons-settings-from-a-shell-script

CONFIG=$HOME/.config/kcminputrc

state () {
  local current_state=$(kreadconfig5 --file $CONFIG --group Mouse --key XLbInptLeftHanded)

  if [ "$current_state" = "true" ]; then
    echo "left"
  else
    echo "right"
  fi
}

format_for_polybar () {
  local click_action="$0 swap"
  local icon

  icon=""

  echo "%{A1:$click_action:}%{A3:$click_action:}$icon $(state)%{A}%{A}"
}

right () {
  kwriteconfig5 --file $CONFIG --group Mouse --key XLbInptLeftHanded false

  kcminit kcm_mouse
}

left () {
  kwriteconfig5 --file $CONFIG --group Mouse --key XLbInptLeftHanded true

  kcminit kcm_mouse
}

swap () {
  if [ "$(state)" = "left" ]; then
    right
  else
    left
  fi
}

if [ "$1" = "state-polybar" ]; then
  format_for_polybar
elif [ "$1" = "left" ]; then
  left
elif [ "$1" = "right" ]; then
  right
elif [ "$1" = "swap" ]; then
  swap
else
  echo "Usage: $0 (left|right|swap|state-polybar)"
  exit 1
fi

# nvim: ft=bash
