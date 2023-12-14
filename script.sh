#!/bin/bash
# Maak een back-up van de originele configuratiebestanden
cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.backup
cp /etc/apache2/conf-available/security.conf /etc/apache2/conf-available/security.conf.backup
# Zet ServerTokens en ServerSignature op minimaal
sed -i '/^ServerTokens/s/.*/ServerTokens Prod/' /etc/apache2/apache2.conf
sed -i '/^ServerSignature/s/.*/ServerSignature Off/' /etc/apache2/apache2.conf
# Activeer mod_security en mod_evasive
sudo a2enmod security2 evasive
# Configureer beveiligingsheaders
echo "Header always set X-Frame-Options DENY" >> /etc/apache2/apache2.conf
echo "Header always set X-XSS-Protection \"1; mode=block\"" >> /etc/apache2/apache2.conf
echo "Header always set X-Content-Type-Options nosniff" >> /etc/apache2/apache2.conf
echo "Header always set Referrer-Policy \"no-referrer-when-downgrade\"" >> /etc/apache2/apache2.conf
# Schakel directorylijsten uit
echo "Options -Indexes" > /var/www/html/.htaccess
# Beperk toegang tot gevoelige bestanden
echo "<FilesMatch \"(\\.htaccess|\\.htpasswd|config\\.php)\">" >> /etc/apache2/apache2.conf
echo " Require all denied" >> /etc/apache2/apache2.conf
echo "</FilesMatch>" >> /etc/apache2/apache2.conf
# Herstart Apache na het aanbrengen van wijzigingen
sudo systemctl restart apache2
