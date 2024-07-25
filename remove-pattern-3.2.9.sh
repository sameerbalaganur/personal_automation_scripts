#!/bin/bash

# Check if an input value was provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <eventRecordQPS>"
    exit 1
fi

# The value for eventRecordQPS to append
eventRecordQPS=$1

# The file to modify
FILE_PATH="/etc/systemd/system/kubelet.service.d/10-kubelet-args.conf"

# Check if the file exists
if [ ! -f "$FILE_PATH" ]; then
    echo "File does not exist: $FILE_PATH"
    exit 1
fi

# Append --event-record-qps=<input-value> inside the single quotes of KUBELET_ARGS
sudo sed -i "/KUBELET_ARGS=/ s|'$| --event-record-qps=$eventRecordQPS'|" "$FILE_PATH"

echo "Added --event-record-qps=$eventRecordQPS to KUBELET_ARGS in $FILE_PATH"

# Reload systemd and restart kubelet service
sudo systemctl daemon-reload
sudo systemctl restart kubelet

echo "Systemd reloaded and kubelet restarted."
