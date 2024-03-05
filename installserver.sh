#!/bin/bash

echo "Updating system if necessary..."
sudo apt update && sudo apt upgrade

echo "Installing requirements..."
sudo apt install git curl screen openjdk-17-jdk

echo "Creating working directory..."
mkdir ./mc-tmp

cd ./mc-tmp

echo "Downloading buildtools..."
wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

echo "Compiling server.jar..."
java -jar BuildTools.jar --final-name server.jar

cd ..

echo "Adding final directory..."
sudo mkdir /var/minecraft

echo "Adding minecraft user..."
sudo groupadd -r minecraft

sudo useradd -r -g minecraft -d "/var/minecraft" -s "/bin/bash" minecraft

echo "Copying files to final directory..."
sudo mv ./mc-tmp /var/minecraft/server

sudo mv startserver.sh /var/minecraft/server/startserver.sh

sudo mv minecraft.service /etc/systemd/system/minecraft.service

echo "Setting permissions..."
sudo chown minecraft.minecraft -R /var/minecraft/

echo "Restarting systemd deamon..."
sudo systemctl daemon-reload

echo "Enabling minecraft service..."
sudo systemctl enable minecraft

echo "Accepting EULA..."
sudo echo "eula=true" > /var/minecraft/server/eula.txt

echo "Starting the server for the first time..."
sudo systemctl start minecraft

echo "Sleeping for 1 Minute..."
sleep 1m

echo "Stopping the server..."
sudo systemctl stop minecraft

echo "Starting the server..."
sudo systemctl start minecraft

echo "Ready..."
