#!/bin/bash

scrot -u -e 'mv $f ~/Pictures/temp' && notify-send --app-name=scrot --icon=/usr/share/icons/Papirus/128x128/apps/screengrab.svg "Taking a screenshot!" "Screenshot saved at ~/Pictures/temp/"
