#!/bin/bash

# Remove Server Version Banner
echo "ServerTokens Prod" | sudo tee -a /etc/apache2/conf-available/security.conf
echo "ServerSignature Off" | sudo tee -a /etc/apache2/conf-available/security.conf
sudo a2enconf security
sudo systemctl restart apache2

# Disable directory browser listing
sudo sed -i 's/Options Indexes/Options -Indexes/g' /etc/apache2/apache2.conf
sudo systemctl restart apache2

# Configure ETag
echo "FileETag None" | sudo tee -a /etc/apache2/conf-available/security.conf
sudo systemctl restart apache2

# Run Apache from a non-privileged account
sudo groupadd apache
sudo useradd -g apache apache
sudo chown -R apache:apache /etc/apache2/
sudo sed -i 's/User www-data/User apache/g' /etc/apache2/apache2.conf
sudo sed -i 's/Group www-data/Group apache/g' /etc/apache2/apache2.conf
sudo systemctl restart apache2

# Protect binary and configuration directory permission
sudo chmod -R 750 /etc/apache2/{bin,conf}

# System Settings Protection
sudo sed -i '/<Directory \/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride None\nOptions -Indexes/' /etc/apache2/apache2.conf
sudo systemctl restart apache2

# HTTP Request Methods
echo "<LimitExcept GET POST HEAD>
deny from all
</LimitExcept>" | sudo tee -a /etc/apache2/apache2.conf
sudo systemctl restart apache2

# Disable Trace HTTP Request
echo "TraceEnable off" | sudo tee -a /etc/apache2/apache2.conf
sudo systemctl restart apache2

# Set cookie with HttpOnly and Secure flag
echo "Header edit Set-Cookie ^(.*)$ $1;HttpOnly;Secure" | sudo tee -a /etc/apache2/apache2.conf
sudo systemctl restart apache2

# Clickjacking Attack
echo "Header always append X-Frame-Options SAMEORIGIN" | sudo tee -a /etc/apache2/apache2.conf
sudo systemctl restart apache2

# Disable HTTP 1.0 Protocol
echo "RewriteEngine On
RewriteCond %{THE_REQUEST} !HTTP/1.1$
RewriteRule .* - [F]" | sudo tee -a /etc/apache2/apache2.conf
sudo systemctl restart apache2

# Timeout value configuration
echo "Timeout 60" | sudo tee -a /etc/apache2/apache2.conf
sudo systemctl restart apache2

# SSL Configuration (if applicable)
# Modify SSL configuration as per requirements
# ...

# Mod Security (if applicable)
# Install and configure Mod Security as needed
# ...

echo "Apache server secured!"
