##################################
#Install Nagios Core in Ubuntu 22.04.x
##################################
#Reference: 
#https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/4/en/quickstart-ubuntu.html
#https://kifarunix.com/install-and-setup-nagios-on-ubuntu-22-04/
#https://www.virtono.com/community/tutorial-how-to/how-to-install-nagios-on-ubuntu-22-04/#Extract_and_Compile_Nagios_Core
#https://hostadvice.com/how-to/web-hosting/ubuntu/how-to-install-nagios-on-an-ubuntu/
#https://www.tecmint.com/install-nagios-core-in-ubuntu-and-debian/
##################################


apt update -y

apt install nano make apache2-utils build-essential vautoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php libgd-dev libssl-dev -y

wget https://go.nagios.org/get-core/4-5-2/nagios-4.5.2.tar.gz
tar xzf nagios-4.5.2.tar.gz
cd nagios-4.5.2.tar.gz
ls
./configure --with-httpd-conf=/etc/apache2/sites-enabled
make all
make install
make install-init
make install-commandmode
systemctl enable nagios.service
make install-config
make install-webconf
htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
a2enmod cgi
systemctl restart apache2
systemctl start nagios
systemctl enable nagios


make install-groups-users
usermod -aG nagios www-data

make install-daemoninit




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
