#!/bin/bash

# Get the network interface details
ifconfig_output=$(ifconfig)

# Extract and print the relevant information
echo "$ifconfig_output" | awk '
BEGIN {
    interface = "";
    ip_address = "";
}

/^([a-z0-9]+): flags=/ {
    if (interface != "" && ip_address != "") {
        print interface ": " ip_address;
    }
    interface = $1;
    ip_address = "";
}

/inet / && $2 ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/ {
    ip_address = $2;
}

END {
    if (interface != "" && ip_address != "") {
        print interface ": " ip_address;
    }
}'
