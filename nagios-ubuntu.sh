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
useradd nagios
usermod -a -G nagios www-data
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
systemctl enable apache2
systemctl start nagios
systemctl enable nagios
systemctl restart nagios
#Access Nagios Dashboard: http://IP-Address/nagios
systemctl restart nagios
echo -e "http://Nagios-Server-IP-OR-Hostname/nagios"
echo -e " Deafult User(nagioadmin) "
echo -e " Deafult Password(Which You Given When Exec This Shell ) "

#Install Nagios Plugins on Ubuntu 22.04.x

apt install libmcrypt-dev make libssl-dev bc gawk dc build-essential snmp libnet-snmp-perl gettext libldap2-dev smbclient fping libmysqlclient-dev libdbi-dev -y
wget https://github.com/nagios-plugins/nagios-plugins/releases/download/release-2.4.0/nagios-plugins-2.4.0.tar.gz
tar xzf nagios-plugins-2.4.0.tar.gz
cd nagios-plugins-2.4.0
./tools/setup 
./configure 
make
make install
ls /usr/local/nagios/libexec/
#./configure --with-nagios-user=nagios --with-nagios-group=nagios
systemctl restart nagios.service
a2enmod ssl 
a2ensite default-ssl.conf
systemctl restart apache2
systemctl restart nagios

#If you receive an error like this one:
#Edit the config file:
#nano /usr/local/nagios/etc/nagios.cfg
#And replace the 1 with a 0 in the check_for_updates line:
#check_for_updates=0
#sed -i 's/check_for_updates=1/check_for_updates=0/' /usr/local/nagios/etc/nagios.cfg

sudo systemctl enable nagios
sudo systemctl enable apache2

/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

#Configuring Nagios
#Include the email address where you want to be receiving monitoringn alerts.
#vi /usr/local/nagios/etc/objects/contacts.cfg
#it in one line with the following command, replacing “myemail” with your email:

sed -i 's/nagios@localhost/sumonpaul267@gmail.com/' /usr/local/nagios/etc/objects/contacts.cfg

/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

systemctl restart apache2
systemctl restart nagios

echo -e " Deafult User(nagioadmin) "
echo -e " Deafult Password(Which You Given When Exec This Shell ) "


