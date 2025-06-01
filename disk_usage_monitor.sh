#!/bin/bash

# === Configuration Section ===
THRESHOLD=85          # Disk usage percentage threshold
RECIPIENT="admin@example.com"  # Email address to notify
SUBJECT="⚠️ Low Disk Space Alert on $(hostname)"
EMAIL_BODY="/tmp/disk_usage_alert.txt"
LOG_FILE="/var/log/disk_usage_monitor.log"

# === Logging Function ===
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# === Main Script ===
log_message "Starting disk usage check..."

# Get current root partition usage percentage
USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if [[ "$USAGE" -ge "$THRESHOLD" ]]; then
    log_message "Disk usage is above ${THRESHOLD}% (Current: ${USAGE}%)"

    echo "The root filesystem on $(hostname) is currently at ${USAGE}% disk usage." > "$EMAIL_BODY"
    echo "" >> "$EMAIL_BODY"
    echo "=== Disk Usage Summary ===" >> "$EMAIL_BODY"
    df -h / >> "$EMAIL_BODY"
    echo "" >> "$EMAIL_BODY"
    echo "Generated on: $(date)" >> "$EMAIL_BODY"

    # Send email using mail command
    if command -v mail &> /dev/null; then
        cat "$EMAIL_BODY" | mail -s "$SUBJECT" "$RECIPIENT"
        log_message "Email alert sent to $RECIPIENT"
    else
        log_message "Error: 'mail' command not found. Install mailutils or postfix to send emails."
    fi

else
    log_message "Disk usage is normal (Current: ${USAGE}%)"
fi

log_message "Disk check completed."
