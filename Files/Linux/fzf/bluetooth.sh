#!/bin/bash
choice=$(echo -e "Connect\nDisconnect\nPower On\nPower Off" | fzf --prompt="Bluetooth: " | cut -d. -f1)

devices=$(bluetoothctl devices Paired | awk '{print $2, $3}')

if [[ "$choice" == "Connect" ]]; then
	name=$(echo "$devices" | awk '{print $2}' | fzf --prompt="Connect: ")
	mac=$(echo "$devices" | grep "$name" | awk '{print $1}')
	if [ -n "$mac" ]; then
	   bluetoothctl connect "$mac"
	fi
elif [[ "$choice" == "Disconnect" ]]; then
	bluetoothctl disconnect

elif [[ "$choice" == "Power On" ]]; then
	bluetoothctl power on

elif [[ "$choice" == "Power Off" ]]; then
	bluetoothctl power off
fi

