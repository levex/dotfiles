#!/bin/bash

export XAUTHORITY=/home/lkurusa/.Xauthority
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export XDG_SEAT_PATH=/org/freedesktop/DisplayManager/Seat0
export XDG_SESSION_PATH=/org/freedesktop/DisplayManager/Session0

/usr/bin/notify-send --icon=/home/lkurusa/sw/eye-logo.jpg --app-name=newsboat -t 300000 -- "20-20-20 Rule" "Look away for 20 seconds at an object 20ft away"
