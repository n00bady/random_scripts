#!/usr/bin/env bash

# Simple battery notification bash script for running as a root cron job
# Shuting down if battery lower than 15%

# Need to find my dbus session first
username=$(/usr/bin/whoami)
pid=$(pgrep -u $username polybar)
dbus=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$pid/environ | sed 's/DBUS_SESSION_BUS_ADDRESS=//')
export DBUS_SESSION_BUS_ADDRESS=$dbus

battery_state="$(acpi -b | cut -d " " -f 3)"
battery_state=${battery_state::-1}
# Check battery percentage with acpi and only keep the number
battery="$(acpi -b | cut -d "," -f 2)"
battery=${battery::-1}

if [ $battery_state = "Discharging" ]; then
    if [ $battery -lt 15 ]; then
        notify-send -i /usr/share/icons/Ultimate-Punk-Suru++/devices/32/battery.svg -t 5000 -u critical 'Battery Warning!' "Battery at $battery %, shutting down in 1 minute"
        sleep 1
        /usr/bin/shutdown -P +1 "Low battery, shutting down system in 1min..."
    elif [ $battery -lt 25 ]; then
        notify-send -i /usr/share/icons/Ultimate-Punk-Suru++/devices/32/battery.svg -t 5000 'Battery Warning!' "$battery %"
    else
        :
    fi
else
    :
fi

