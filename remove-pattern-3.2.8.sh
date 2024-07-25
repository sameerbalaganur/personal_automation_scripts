#!/bin/bash

CONFIG_FILE="/etc/systemd/system/kubelet.service.d/10-kubelet-args.conf"

echo "Checking for --hostname-override in kubelet configuration..."

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file does not exist: $CONFIG_FILE"
    sudo cp "$CONFIG_FILE" "${CONFIG_FILE}.bak"
    exit 1
fi

if grep -q '\--hostname-override' $CONFIG_FILE; then
    echo "--hostname-override found, attempting to remove..."

    # Use sudo specifically for the sed command if necessary
    sudo sed -i 's/--hostname-override=[^ ]* //' $CONFIG_FILE

    # Reloading systemd manager configuration, assuming the script is run with appropriate permissions
    sudo systemctl daemon-reload

    # Restarting kubelet to apply changes
    sudo systemctl restart kubelet.service

    echo "kubelet service restarted without --hostname-override."
else
    echo "--hostname-override not found in kubelet configuration."
fi
