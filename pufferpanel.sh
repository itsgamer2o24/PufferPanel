#!/bin/bash

# Function to display messages
echo_message() {
    echo "\033[1;32m$1\033[0m"
}

echo_message "Do you want to install the PufferPanel? (yes/no)"

read answer

if [ "$answer" != "yes" ]; then
    echo_message "Installation aborted."
    exit 0
fi

echo_message "* Create a Password"

sudo passwd

echo_message "* Installing Dependencies"

# Update package list and install dependencies
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install sudo
clear

echo_message "* Installed Files"

# Create directory, clone repository, and install files
mkdir -p /var/lib/pufferpanel
docker volume create pufferpanel-config
clear

echo_message "* Installed Pufferpanel "

# Create directory, clone repository, and install files
docker create --name pufferpanel -p 8080:8080 -p 5657:5657 -v pufferpanel-config:/etc/pufferpanel -v /var/lib/pufferpanel:/var/lib/pufferpanel -v /var/run/docker.sock:/var/run/docker.sock --restart=on-failure pufferpanel/pufferpanel:latest
clear

echo_message "* Create The User"

# Run setup scripts
 docker start pufferpanel
 clear

echo_message "* Pufferpanel Installed and Started on Port 8080"

echo_message "* Starting Pufferpanel"

# Start the Pufferpanel
docker exec -it pufferpanel /pufferpanel/pufferpanel user add
clear
