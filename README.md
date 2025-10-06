# 🛠️ Linux System Administration Toolbox

> **A comprehensive collection of robust bash scripts for cross-platform Linux system management, automation, and development workflows.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux-blue.svg)](https://www.linux.org/)
[![Cross-Platform](https://img.shields.io/badge/Supports-Ubuntu%20%7C%20RHEL%20%7C%20CentOS%20%7C%20Amazon%20Linux-orange.svg)](#supported-distributions)

---

## 🎯 **What This Toolbox Provides**

This repository contains **production-ready bash scripts** designed for **system administrators**, **DevOps engineers**, and **developers** who need reliable, cross-platform tools for Linux system management. Each script is built with **safety checks**, **error handling**, and **automation support**.

### ✨ **Key Features**
- 🏗️ **Cross-Platform Compatibility** - Works across Ubuntu, RHEL, CentOS, Amazon Linux, Fedora, and more
- 🚀 **Automation Ready** - Command-line interfaces with force modes for EC2 templates and CI/CD
- 🔒 **Safety First** - Built-in protections against system directory corruption
- 📋 **Copy-Paste Ready** - Quick reference commands for immediate use
- 🎛️ **Interactive & Silent Modes** - Menu-driven interfaces and automated execution options

---

## 📦 **Script Collection**

### 🔧 **System Management Scripts**

#### [`system-groups.sh`](./system-groups.sh)
**Advanced cross-platform user and group management tool**
- 🌐 **Multi-Distribution Support**: Automatic detection of Ubuntu, Amazon Linux, RHEL, CentOS, Debian
- 👥 **Smart Group Management**: Handles `sudo` vs `wheel` group differences automatically
- 🛡️ **Safety Protection**: Validates paths to prevent system directory corruption
- ⚡ **Automation Ready**: `--force` mode for unattended execution in EC2 templates
- 🎯 **File Ownership**: Secure `takeOwnership` function with comprehensive validation

```bash
# Interactive mode
./system-groups.sh

# Automation mode
./system-groups.sh --force --user username --group sudo --path /var/www
```

#### [`ubuntu-system-update.sh`](./ubuntu-system-update.sh)
**Intelligent system update manager with package manager detection**
- 🔍 **Auto-Detection**: Automatically detects `apt` (Ubuntu/Debian) or `yum` (RHEL/CentOS)
- 📋 **Menu-Driven**: User-friendly interface for update operations
- 🔄 **Comprehensive Updates**: System packages, security updates, and cleanup operations
- 📊 **Status Reporting**: Clear feedback on update progress and results

#### [`system-reboot.sh`](./system-reboot.sh) & [`system-rebootV2.sh`](./system-rebootV2.sh)
**Safe system restart utilities**
- ⏰ **Scheduled Reboots**: Configurable delay timers
- 🛡️ **Safety Checks**: Process validation before restart
- 📢 **User Notifications**: Warning messages for active sessions

#### [`ubuntu-system-shutdown.sh`](./ubuntu-system-shutdown.sh)
**Controlled system shutdown utility**
- 🔒 **Graceful Shutdown**: Proper service termination
- ⏱️ **Configurable Timing**: Delayed shutdown options
- 📋 **Process Management**: Active session handling

### 🐳 **Development Environment Scripts**

#### [`install-docker-copyPaste.sh`](./install-docker-copyPaste.sh)
**Docker installation commands for multiple Linux distributions**
- 📋 **Copy-Paste Ready**: One-line installation commands
- 🌐 **Multi-Platform**: Ubuntu, CentOS, RHEL, Amazon Linux support
- 🔧 **Complete Setup**: Docker engine, compose, and user permissions

#### [`ubuntu-install-dockerCompose.sh`](./ubuntu-install-dockerCompose.sh)
**Docker Compose installation utility**
- 📦 **Latest Version**: Automatically fetches current stable release
- 🔗 **Dependency Management**: Handles Docker engine prerequisites
- ✅ **Verification**: Post-installation testing and validation

#### [`install-makefile-copyPaste.sh`](./install-makefile-copyPaste.sh)
**Make and build tools installation reference**
- 🏗️ **Make Installation**: Commands for all major Linux distributions
- 🔍 **Information & Debugging**: Comprehensive make CLI reference
- 🚀 **Execution Control**: Parallel jobs, error handling, dry-run options
- 📁 **File & Directory**: Custom makefile and include directory options
- 🔧 **Advanced Features**: Force rebuild, environment overrides, analysis tools
- 📊 **Utilities**: Target listing, variable inspection, performance profiling

### 🗄️ **Database Management Scripts**

#### [`ubuntu-mysql.sh`](./ubuntu-mysql.sh)
**MySQL server installation and configuration**
- 🔧 **Complete Setup**: Server installation, user creation, security configuration
- 🔒 **Security Hardening**: Secure installation procedures
- 📊 **Database Management**: Initial database and user setup

#### [`ubuntu-mysql-phpmyadmin.sh`](./ubuntu-mysql-phpmyadmin.sh)
**MySQL with phpMyAdmin web interface**
- 🌐 **Web Interface**: Complete phpMyAdmin installation and configuration
- 🔗 **Integration**: Seamless MySQL and web server integration
- 🔒 **Security Configuration**: Proper authentication and access controls

### ☁️ **Cloud & Infrastructure Scripts**

#### [`aws-CLI-create-lamp.sh`](./aws-CLI-create-lamp.sh)
**AWS LAMP stack deployment automation**
- ☁️ **Cloud Ready**: Optimized for EC2 instances
- 📦 **Complete Stack**: Linux, Apache, MySQL, PHP installation
- 🚀 **One-Command Deploy**: Automated infrastructure setup

#### [`aws-linux-java.sh`](./aws-linux-java.sh)
**Java development environment for Amazon Linux**
- ☕ **Java Setup**: JDK installation and configuration
- 🔧 **Environment Configuration**: PATH and JAVA_HOME setup
- ✅ **Verification**: Installation testing and validation

#### [`config_webserver.sh`](./config_webserver.sh)
**Web server configuration utility**
- 🌐 **Multi-Server Support**: Apache, Nginx configuration options
- 🔧 **Optimization**: Performance tuning and security hardening
- 📁 **Document Root**: Automated directory structure setup

### 🛠️ **Utility Scripts**

#### [`CLI-Colors.sh`](./CLI-Colors.sh)
**Terminal color and formatting utilities**
- 🎨 **Color Output**: ANSI color code definitions
- 📝 **Text Formatting**: Bold, underline, and styling functions
- 🎯 **User Experience**: Enhanced script readability and feedback

#### [`git-commands.sh`](./git-commands.sh)
**Git workflow automation and shortcuts**
- 🔄 **Workflow Automation**: Common git operation shortcuts
- 📋 **Command Reference**: Quick copy-paste git commands
- 🚀 **Productivity**: Streamlined development workflows

#### [`system-groups-copyPaste.sh`](./system-groups-copyPaste.sh)
**Quick reference for system group commands**
- 📋 **Command Library**: Copy-paste ready group management commands
- 🔧 **Cross-Platform**: Commands for different Linux distributions
- ⚡ **Quick Access**: Instant command reference without menu navigation

---

## 🌐 **Supported Distributions**

| Distribution | Package Manager | Status | Notes |
|-------------|----------------|---------|-------|
| **Ubuntu** | `apt` | ✅ Fully Supported | LTS versions 18.04+ |
| **Debian** | `apt` | ✅ Fully Supported | Stable releases |
| **Amazon Linux 2** | `yum` | ✅ Fully Supported | EC2 optimized |
| **Amazon Linux 2023** | `dnf` | ✅ Fully Supported | Latest AL2023 |
| **RHEL 8+** | `dnf` | ✅ Fully Supported | Enterprise ready |
| **CentOS 7/8** | `yum`/`dnf` | ✅ Fully Supported | Community enterprise |
| **Fedora** | `dnf` | ✅ Fully Supported | Latest releases |
| **Alpine Linux** | `apk` | ✅ Supported | Container optimized |
| **Arch Linux** | `pacman` | ✅ Supported | Rolling release |
| **SUSE/openSUSE** | `zypper` | ✅ Supported | Enterprise and community |

---

## 🚀 **Quick Start Guide**

### 1. **Clone the Repository**
```bash
git clone https://github.com/gitmikebrown/bash.git
cd bash
```

### 2. **Make Scripts Executable**
```bash
chmod +x *.sh
```

### 3. **Run Interactive Scripts**
```bash
# Cross-platform user management
./system-groups.sh

# System updates with auto-detection
./ubuntu-system-update.sh
```

### 4. **Use in Automation** (EC2 User Data, CI/CD)
```bash
# Automated user setup for EC2 instances
./system-groups.sh --force --user ec2-user --group sudo --path /var/www

# Copy individual commands from reference files
cat install-makefile-copyPaste.sh  # Copy desired commands
```

---

## 💡 **Usage Patterns**

### **🎛️ Interactive Mode** (Local Development)
Perfect for **development environments** and **manual system administration**:
```bash
./system-groups.sh          # Menu-driven user management
./ubuntu-system-update.sh   # Interactive system updates
```

### **🤖 Automation Mode** (Production/CI-CD)
Ideal for **EC2 user data**, **Docker containers**, and **CI/CD pipelines**:
```bash
./system-groups.sh --force --user deploy --group wheel --path /opt/app
curl -s https://raw.githubusercontent.com/gitmikebrown/bash/main/install-docker-copyPaste.sh | grep "sudo apt-get" | bash
```

### **📋 Copy-Paste Reference** (Quick Commands)
Use reference files for **immediate command access**:
- `install-makefile-copyPaste.sh` - Make installation across distributions
- `install-docker-copyPaste.sh` - Docker setup commands
- `system-groups-copyPaste.sh` - System group management shortcuts

---

## 🔒 **Security & Safety Features**

- **✅ Path Validation**: Prevents accidental system directory modification
- **✅ User Verification**: Confirms user existence before operations
- **✅ Group Detection**: Automatically handles distribution-specific groups
- **✅ Error Handling**: Comprehensive error checking and recovery
- **✅ Dry-Run Options**: Test operations before execution
- **✅ Logging**: Operation tracking and audit trails

---

## 🤝 **Contributing**

We welcome contributions! Please:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Test** your changes across multiple distributions
4. **Commit** with clear messages (`git commit -m 'Add amazing feature'`)
5. **Push** to your branch (`git push origin feature/amazing-feature`)
6. **Open** a Pull Request

### **Development Guidelines**
- ✅ Test on Ubuntu, Amazon Linux, and CentOS minimum
- ✅ Include error handling and safety checks
- ✅ Add comments and documentation
- ✅ Follow existing code style and structure
- ✅ Update README.md for new features

---

<div align="center">

**⭐ Star this repository if you find it useful! ⭐**

**Built with ❤️ for the Linux community**

</div>
