#!/bin/bash
# Add vagrant user to sudoers.
echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers


sudo apt update
sudo apt upgrade -y
sudo apt-get install -y apache2

sudo apt-get install -y ufw
sudo ufw --force  enable 


sudo ufw allow 22/tcp
sudo ufw allow 80/tcp

sudo apt-get install -y apache2-bin
sudo apt-get install -y libxml2-dev
sudo a2enmod proxy
sudo a2enmod proxy_html
sudo a2enmod proxy_http

systemctl restart apache2

echo "# Allgemeine Proxy Einstellungen" >> /etc/apache2/sites-available/001-reverseproxy.conf
echo "ProxyRequests Off" >> /etc/apache2/sites-available/001-reverseproxy.conf
echo "<Proxy *>" >> /etc/apache2/sites-available/001-reverseproxy.conf
echo "      Order deny,allow" >> /etc/apache2/sites-available/001-reverseproxy.conf
echo "      Allow from all" >> /etc/apache2/sites-available/001-reverseproxy.conf
echo "</Proxy>" >> /etc/apache2/sites-available/001-reverseproxy.conf
echo "" >> /etc/apache2/sites-available/001-reverseproxy.conf
echo "# Weiterleitungen master" >> /etc/apache2/sites-available/001-reverseproxy.conf
echo "ProxyPass /master http://master" >> /etc/apache2/sites-available/001-reverseproxy.conf
echo "ProxyPassReverse /master http://master  " >> /etc/apache2/sites-available/001-reverseproxy.conf

sudo ln -s /etc/apache2/sites-available/001-reverseproxy.conf /etc/apache2/sites-enabled/
sudo service apache2 restart
sudo service cron reload