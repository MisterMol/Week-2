#!/bin/bash
# Backup the original configuration files
cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.backup
cp /etc/apache2/conf-available/security.conf /etc/apache2/conf-available/security.conf.backup
# Set ServerTokens and ServerSignature to minimal
sed -i 's/^ServerTokens.*/ServerTokens Prod/' /etc/apache2/apache2.conf
sed -i 's/^ServerSignature.*/ServerSignature Off/' /etc/apache2/apache2.conf
# Enable mod_security and mod_evasive
sudo a2enmod security2 evasive
# Configure security headers
echo "Header always set X-Frame-Options DENY" >> /etc/apache2/apache2.conf
echo "Header always set X-XSS-Protection \"1; mode=block\"" >> /etc/apache2/apache2.conf
echo "Header always set X-Content-Type-Options nosniff" >> /etc/apache2/apache2.conf
echo "Header always set Referrer-Policy \"no-referrer-when-downgrade\"" >>
/etc/apache2/apache2.conf
# Disable directory listing
echo "Options -Indexes" > /var/www/html/.htaccess
# Restrict access to sensitive files
echo "<FilesMatch \"(\\.htaccess|\\.htpasswd|config\\.php)\">" >> /etc/apache2/apache2.conf
echo " Require all denied" >> /etc/apache2/apache2.conf
echo "</FilesMatch>" >> /etc/apache2/apache2.conf
# Restart Apache after making changes
sudo systemctl restart apache2 