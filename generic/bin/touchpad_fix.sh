#!/bin/bash

DEVID=$(xinput | grep Touchpad | awk '{ print $6; }' | cut -d = -f2)
PROPID=$(xinput list-props $DEVID | grep 'Disable While Typing Enabled (' | cut -d'(' -f 2 | cut -d')' -f 1)
xinput set-prop $DEVID $PROPID 0
