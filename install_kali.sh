#!/bin/bash

# Script version and metadata
VERSION="2.0.0"
LAST_UPDATED="2025-03-06"
AUTHOR="Lucky7897"

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration variables
INSTALL_LOG="/var/log/kali_install.log"
BACKUP_DIR="/root/pre_kali_backup"

# Function to log messages
log_message() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$INSTALL_LOG"
}

# Function to show progress
show_progress() {
    echo -ne "$1: ${GREEN}[$2%]${NC}\r"
}

# Function to check system requirements
check_requirements() {
    log_message "Checking system requirements..."
    
    # Check RAM
    total_ram=$(free -m | awk '/^Mem:/{print $2}')
    if [ "$total_ram" -lt 4000 ]; then
        echo -e "${RED}Warning: Less than 4GB RAM detected. Installation might be slow.${NC}"
    fi
    
    # Check disk space
    free_space=$(df -h / | awk 'NR==2 {print $4}' | sed 's/G//')
    if [ "${free_space%.*}" -lt 50 ]; then
        echo -e "${RED}Error: Insufficient disk space. At least 50GB required.${NC}"
        exit 1
    fi
}

# Function to backup important configurations
backup_system() {
    log_message "Creating system backup..."
    mkdir -p "$BACKUP_DIR"
    cp /etc/fstab "$BACKUP_DIR/"
    cp /etc/hosts "$BACKUP_DIR/"
    cp /etc/resolv.conf "$BACKUP_DIR/"
}

# Function to select Kali variant
select_kali_variant() {
    echo -e "${YELLOW}Select Kali Linux variant:${NC}"
    echo "1) Kali Linux Default"
    echo "2) Kali Linux Full"
    echo "3) Kali Linux Purple"
    echo "4) Kali ARM (for ARM-based systems)"
    read -rp "Enter choice [1-4]: " variant_choice
    
    case $variant_choice in
        1) KALI_VARIANT="default" ;;
        2) KALI_VARIANT="full" ;;
        3) KALI_VARIANT="purple" ;;
        4) KALI_VARIANT="arm" ;;
        *) KALI_VARIANT="default" ;;
    esac
}

# Function to select desktop environment
select_desktop_environment() {
    echo -e "${YELLOW}Select Desktop Environment:${NC}"
    echo "1) XFCE4 (Lightweight)"
    echo "2) GNOME (Modern)"
    echo "3) KDE Plasma (Feature-rich)"
    echo "4) MATE (Traditional)"
    read -rp "Enter choice [1-4]: " de_choice
    
    case $de_choice in
        1) DE_PACKAGE="xfce4 xfce4-goodies" ;;
        2) DE_PACKAGE="gnome" ;;
        3) DE_PACKAGE="kde-plasma-desktop" ;;
        4) DE_PACKAGE="mate-desktop-environment" ;;
        *) DE_PACKAGE="xfce4 xfce4-goodies" ;;
    esac
}

# Function to configure remote access
configure_remote_access() {
    echo -e "${YELLOW}Configure Remote Access:${NC}"
    read -rp "Install RDP? (y/n): " install_rdp
    read -rp "Install VNC? (y/n): " install_vnc
    read -rp "Custom SSH port (default 22): " ssh_port
    
    if [ "$install_rdp" = "y" ]; then
        install_rdp_service
    fi
    
    if [ "$install_vnc" = "y" ]; then
        install_vnc_service
    fi
    
    if [ -n "$ssh_port" ]; then
        configure_ssh_port "$ssh_port"
    fi
}

# Function to install security features
install_security_features() {
    log_message "Installing security features..."
    
    # Install and configure UFW
    apt install -y ufw
    ufw default deny incoming
    ufw default allow outgoing
    ufw allow ssh
    ufw allow http
    ufw allow https
    
    # Install and configure Fail2ban
    apt install -y fail2ban
    cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
    
    # Install system monitoring tools
    apt install -y rkhunter chkrootkit
}

# Main installation function
main() {
    # Display welcome message
    echo -e "${GREEN}=== Kali Linux Advanced Installer v${VERSION} ===${NC}"
    echo -e "${YELLOW}Author: ${AUTHOR}${NC}"
    echo -e "${YELLOW}Last Updated: ${LAST_UPDATED}${NC}"
    
    # Check requirements
    check_requirements
    
    # Create backup
    backup_system
    
    # Get user preferences
    select_kali_variant
    select_desktop_environment
    configure_remote_access
    
    # Begin installation
    log_message "Beginning Kali Linux installation..."
    
    # Update system
    apt update && apt upgrade -y
    
    # Add Kali repositories
    echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" | tee /etc/apt/sources.list.d/kali.list
    wget -q -O - https://archive.kali.org/archive-key.asc | apt-key add -
    
    # Install base system
    apt update
    apt install -y $DE_PACKAGE
    
    # Install security features
    install_security_features
    
    # Install additional tools
    apt install -y git vim htop neofetch docker.io
    
    # Final configuration
    systemctl enable lightdm
    
    log_message "Installation completed successfully!"
    
    # Display completion message
    echo -e "${GREEN}Installation completed successfully!${NC}"
    echo -e "${YELLOW}Please reboot your system to start using Kali Linux.${NC}"
    echo -e "${YELLOW}Installation log available at: ${INSTALL_LOG}${NC}"
}

# Execute main function
main
