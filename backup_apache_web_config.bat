#!/bin/bash

# Variables
BACKUP_DIR="/backup/apache_server"         # Directory where backups will be stored
CONF_DIR="/etc/apache2"                    # Apache configuration directory
WEB_DIR="/var/www/html"                    # Web server content
SSL_DIR="/etc/letsencrypt"                 # SSL certificates (adjust if needed)
DATE=$(date +%Y-%m-%d_%H-%M-%S)            # Timestamp for backup

# Ensure the backup directory exists
mkdir -p "$BACKUP_DIR"

# Step 1: Backup Apache configuration files
echo "Backing up Apache configuration files..."
tar -czf "$BACKUP_DIR/apache_config_$DATE.tar.gz" "$CONF_DIR"

# Step 2: Backup web server content (HTML, PHP, etc.)
echo "Backing up website files..."
tar -czf "$BACKUP_DIR/webfiles_$DATE.tar.gz" "$WEB_DIR"

# Step 3: Backup SSL certificates (if applicable)
if [ -d "$SSL_DIR" ]; then
  echo "Backing up SSL certificates..."
  tar -czf "$BACKUP_DIR/sslcerts_$DATE.tar.gz" "$SSL_DIR"
else
  echo "No SSL certificates directory found, skipping..."
fi

# Optional: Clean up old backups (older than 7 days)
echo "Removing backups older than 7 days..."
find "$BACKUP_DIR" -type f -name "*.gz" -mtime +7 -exec rm {} \;

# Completion message
echo "Backup complete: $DATE"
