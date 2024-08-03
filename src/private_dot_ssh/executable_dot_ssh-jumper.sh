#!/bin/bash

CISCO_ANY_CONNECT_TUN=utun6

function is_home_net() {
    # local ssid=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID:/ { print $2 }')
    local ssid=$(networksetup -getairportnetwork en0 | awk '/ Network:/ { print $4 }')
    if [[ ! ($ssid =~ [Ss]kynet.*) ]] ; then
        # not using home wifi
        false
    elif ifconfig "$CISCO_ANY_CONNECT_TUN" >/dev/null 2>&1 ; then
        # connected to the VPN
        false
    else
        true
    fi
}

if echo "$1" | grep -q "^vm.*\." ; then
    nc "$1" "$2"
elif is_home_net ; then
    nc "$1" "$2"
else
    ssh -W "$1:$2" jumper.genzj.info
fi

