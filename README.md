# Disk Usage Monitor (Bash)

A Bash script that checks the root filesystem's disk usage and sends an email alert if it exceeds a specified threshold.

## 🛠️ Features
- Monitors root (`/`) disk usage in real-time.
- Sends an email alert if disk usage exceeds a configurable threshold.
- Logs all activity to `/var/log/disk_usage_monitor.log`.
- Easy to automate via cron jobs.

## 📦 Prerequisites
Ensure the following are installed/configured:

- A Linux-based OS (Ubuntu, CentOS, etc.)
- `mail` utility (Install via `mailutils` on Debian/Ubuntu or `mailx` on CentOS/RHEL)
  ```bash
  # On Ubuntu/Debian
  sudo apt update && sudo apt install mailutils

  # On CentOS/RHEL
  sudo yum install mailx
