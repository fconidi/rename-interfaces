#!/bin/bash

# Source: https://francoconidi.it
# Source: https://syslinuxos.com

# Array containing the names of the network interfaces to be renamed
interfaces=("en" "wl")

# Loop through the interfaces
for interface in "${interfaces[@]}"; do
  # Get the current name of the network interface
  current_interface=$(ip -o link show | awk -F': ' '{print $2}' | grep -Ei "^$interface")


  # Check if the interface exists
  if [ ! -z "$current_interface" ]; then
    # Get the path of the network interface
    interface_path=$(sudo udevadm info /sys/class/net/"$current_interface" | grep ID_PATH | awk -F'=' '{print $2}')
    
    # Create the configuration file for the renaming
    sudo touch /etc/systemd/network/10-rename-"$current_interface".link
    sudo chmod 644 /etc/systemd/network/10-rename-"$current_interface".link
    
    # Write the renaming rules to the configuration file
    echo "[Match]" | sudo tee -a /etc/systemd/network/10-rename-"$current_interface".link > /dev/null
    echo "Path=$interface_path" | sudo tee -a /etc/systemd/network/10-rename-"$current_interface".link > /dev/null
    echo "[Link]" | sudo tee -a /etc/systemd/network/10-rename-"$current_interface".link > /dev/null

    # Set the new name for the interface based on the type of interface
if [ "$interface" == "en" ]; then
  new_interface_name="eth0${interface_number}"
else
  new_interface_name="wlan0"
fi

echo "Name=$new_interface_name" | sudo tee -a /etc/systemd/network/10-rename-"$current_interface".link > /dev/null



    # Reload the systemd-networkd configuration
    sudo systemctl restart systemd-networkd
  fi
done

