#!/bin/bash

# Update the system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Add Kali repository
echo "Adding Kali repository..."
echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" | sudo tee /etc/apt/sources.list.d/kali.list

# Install Kali keyring
echo "Installing Kali keyring..."
sudo apt install kali-archive-keyring -y

# Update the system again to include Kali packages
echo "Updating system after adding Kali repository..."
sudo apt update

# Install Kali desktop environment (XFCE)
echo "Installing Kali desktop environment (XFCE)..."
sudo apt install kali-desktop-xfce -y

# Set Kali as the default desktop environment (optional)
echo "Setting Kali as the default desktop environment..."
sudo update-alternatives --config x-session-manager

# Reboot the system
echo "Rebooting the system to apply changes..."
sudo reboot
