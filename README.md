# 🎯 Advanced Kali Linux Installer
*Last updated: 2025-03-06*

An advanced installation script that transforms a fresh Ubuntu server into a fully-featured Kali Linux environment with GUI, remote access, and various tools.

## 🚀 Features

- Multiple Kali Linux flavors:
  - Kali Linux Default
  - Kali Linux Full
  - Kali Linux Purple
  - Kali ARM (for ARM-based systems)

- Remote Access:
  - RDP Support (Windows Remote Desktop)
  - SSH with password authentication
  - VNC Server (optional)

- Desktop Environments:
  - XFCE4 (default)
  - GNOME
  - KDE Plasma
  - MATE

- Security Features:
  - UFW Firewall configuration
  - Fail2ban integration
  - Custom SSH port option
  - System hardening options

- Additional Tools:
  - Docker support
  - Development tools
  - Common pentesting tools
  - Productivity applications

## 📋 Requirements

- Fresh Ubuntu Server installation (20.04 LTS or newer)
- Minimum 50GB disk space
- Minimum 4GB RAM (8GB+ recommended)
- Internet connection

## 🛠️ Installation

1. Clone the repository:
```bash
git clone https://github.com/Lucky7897/Kali.git
cd Kali
```

2. Make the script executable:
```bash
chmod +x install_kali.sh
```

3. Run the installer:
```bash
sudo ./install_kali.sh
```

## ⚙️ Configuration Options

During installation, you can customize:
- Kali Linux variant
- Desktop environment
- Remote access options
- Security features
- Additional tools

## 🔒 Security Notice

The script includes basic security measures, but you should:
- Change default passwords after installation
- Review and adjust firewall rules
- Regularly update the system
- Follow security best practices

## 📝 License

MIT License - feel free to modify and distribute!

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.