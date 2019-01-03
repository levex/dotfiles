#!/bin/sh

CAPS_LOCK=66
RIGHT_CTRL=105

# Caps_Lock = Escape, Shift + Caps_Lock = Caps_Lock
xmodmap -e 'remove Lock = Caps_Lock'
xmodmap -e "keycode $CAPS_LOCK = Escape Caps_Lock"
xmodmap -e "keycode $RIGHT_CTRL = Multi_key"
