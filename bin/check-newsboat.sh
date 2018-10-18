#!/bin/bash

export XAUTHORITY=/home/lkurusa/.Xauthority
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export XDG_SEAT_PATH=/org/freedesktop/DisplayManager/Seat0
export XDG_SESSION_PATH=/org/freedesktop/DisplayManager/Session0

# Reload the RSS feeds
/usr/bin/newsboat -x reload

unread=$(/usr/bin/newsboat -x print-unread | /usr/bin/awk '{print $1}')

[[ ${unread} -ne "0" ]] && /usr/bin/notify-send --icon=/home/lkurusa/sw/rss-logo.png --app-name=newsboat -t 300000 -- "Newsboat" "There are ${unread} unread articles."
echo unread: ${unread}
