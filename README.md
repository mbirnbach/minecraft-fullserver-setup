# Minecraft Full Server Setup for Linux
This script installs all required tools, downloads the latest spigot server and installs everything as a systemd service. Linux Only!
Tested with Ubuntu Server.

## Usage
1. Clone this repo onto your server
2. Run `sudo chmod +x installserver.sh`
3. Run `sudo ./installserver.sh`

## Connecting to server console (only while server is running)
1. Switch to user "minecraft" (`sudo su minecraft`)
1. Run `screen -r minecraft`
1. Disconnect using `ctrl + a` followed by `d` (https://wiki.ubuntuusers.de/Screen/)
