#!/bin/bash

# Verwijder Server Version Banner
echo "ServerTokens Prod" >> /opt/apache/conf/httpd.conf
echo "ServerSignature Off" >> /opt/apache/conf/httpd.conf

# Schakel directorylijst uit
echo "<Directory /opt/apache/htdocs>" >> /opt/apache/conf/httpd.conf
echo "Options -Indexes" >> /opt/apache/conf/httpd.conf
echo "</Directory>" >> /opt/apache/conf/httpd.conf

# Etag uitschakelen
echo "FileETag None" >> /opt/apache/conf/httpd.conf

# Voer Apache uit vanuit een niet-privé-account
groupadd apache
useradd -g apache apache
chown -R apache:apache /opt/apache
sed -i 's/User daemon/User apache/' /opt/apache/conf/httpd.conf
sed -i 's/Group daemon/Group apache/' /opt/apache/conf/httpd.conf

# Bescherm rechten van bin en conf mappen
chmod -R 750 /opt/apache/bin /opt/apache/conf

# Schakel AllowOverride uit
sed -i '/<Directory \/>/,/<\/Directory>/ s/AllowOverride All/AllowOverride None/' /opt/apache/conf/httpd.conf

# Beperk HTTP Request Methods
echo "<LimitExcept GET POST HEAD>" >> /opt/apache/conf/httpd.conf
echo "deny from all" >> /opt/apache/conf/httpd.conf
echo "</LimitExcept>" >> /opt/apache/conf/httpd.conf

# Schakel Trace HTTP Request uit
echo "TraceEnable off" >> /opt/apache/conf/httpd.conf

# Zet cookie met HttpOnly en Secure vlag
echo "Header edit Set-Cookie ^(.*)$ $1;HttpOnly;Secure" >> /opt/apache/conf/httpd.conf

# Beveilig tegen Clickjacking-aanvallen
echo "Header always append X-Frame-Options SAMEORIGIN" >> /opt/apache/conf/httpd.conf

# Schakel Server Side Includes uit
sed -i 's/Options Includes/Options -Includes/' /opt/apache/conf/httpd.conf

# Voeg X-XSS Protection toe
echo "Header set X-XSS-Protection \"1; mode=block\"" >> /opt/apache/conf/httpd.conf

# Schakel HTTP 1.0 Protocol uit
echo "RewriteEngine On" >> /opt/apache/conf/httpd.conf
echo "RewriteCond %{THE_REQUEST} !HTTP/1.1$" >> /opt/apache/conf/httpd.conf
echo "RewriteRule .* - [F]" >> /opt/apache/conf/httpd.conf

# Configureer SSL
# (Vereist SSL-certificaten en configuratie)

# Implementeer Mod Security
# (Vereist installatie en configuratie van Mod Security)

# Voer het commando uit om Apache opnieuw te starten
systemctl restart apache2  # Of het relevante opdracht voor jouw systeem om Apache te herstarten

echo "Beveiligingsinstellingen toegepast op Apache-server."
