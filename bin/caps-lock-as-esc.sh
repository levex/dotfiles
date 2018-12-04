#!/bin/sh

CAPS_LOCK=66

# Caps_Lock = Escape, Shift + Caps_Lock = Caps_Lock
xmodmap -e 'remove Lock = Caps_Lock'
xmodmap -e "keycode $CAPS_LOCK = Escape Caps_Lock"
