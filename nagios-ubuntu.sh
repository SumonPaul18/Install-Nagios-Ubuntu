#Install Nagios Core in Ubuntu 22.04.x
#Reference: 
#https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/4/en/quickstart-ubuntu.html
#https://kifarunix.com/install-and-setup-nagios-on-ubuntu-22-04/
#https://www.virtono.com/community/tutorial-how-to/how-to-install-nagios-on-ubuntu-22-04/#Extract_and_Compile_Nagios_Core

apt update -y

apt install autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php libgd-dev libssl-dev -y

wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.7.tar.gz
tar xzf nagios-4.4.7.tar.gz
ls
cd nagios-4.4.7
./configure --with-httpd-conf=/etc/apache2/sites-enabled
make all
make install-groups-users
usermod -aG nagios www-data
make install
make install-init
make install-daemoninit
make install-config
make install-commandmode
make install-webconf
a2enmod rewrite cgi
htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
systemctl enable --now nagios
systemctl restart nagios
#systemctl status nagios
systemctl restart apache2
systemctl enable --now apache2
#ufw allow Apache

echo -e "http://Nagios-Server-IP-OR-Hostname/nagios"

#Install Nagios Plugins on Ubuntu 22.04

sudo apt update
sudo apt install nagios-plugins
cp /usr/lib/nagios/plugins/* /usr/local/nagios/libexec/

sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
sudo systemctl restart nagios
sudo systemctl restart apache2
sudo ln -s /etc/apache2/sites-available/nagios.conf /etc/apache2/sites-enabled/
sudo a2enmod cgi rewrite

sudo systemctl enable nagios
sudo systemctl enable apache2
sudo systemctl restart nagios
sudo systemctl restart apache2
