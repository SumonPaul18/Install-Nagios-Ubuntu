##################################
#Install Nagios Core in Ubuntu 22.04.x
##################################
#Reference: 
#https://hostadvice.com/how-to/web-hosting/ubuntu/how-to-install-nagios-on-an-ubuntu/
#https://www.tecmint.com/install-nagios-core-in-ubuntu-and-debian/
##################################


apt update && apt upgrade -y

apt install nano make apache2-utils build-essential autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php libgd-dev libssl-dev -y
make install-groups-users
useradd nagios
usermod -a -G nagios www-data
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.7.tar.gz
tar -zxvf ./nagios-4.4.7.tar.gz
cd nagios-4.4.7
ls
./configure --with-httpd-conf=/etc/apache2/sites-enabled
make all
make install
make install-init
make install-daemoninit
make install-commandmode
systemctl start nagios
systemctl enable nagios
#If you receive an error like this one:
#Edit the config file:
#nano /usr/local/nagios/etc/nagios.cfg
#And replace the 1 with a 0 in the check_for_updates line:
#check_for_updates=0
sed -i 's/check_for_updates=1/check_for_updates=0/' /usr/local/nagios/etc/nagios.cfg
systemctl start nagios
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
echo -e "http://Nagios-Server-IP-OR-Hostname/nagios"
echo -e " Deafult User(nagioadmin) "
echo -e " Deafult Password(Which You Given When Exec This Shell ) "

#Install Nagios Plugins on Ubuntu 22.04.x

apt install libmcrypt-dev make libssl-dev bc gawk dc build-essential snmp libnet-snmp-perl gettext libldap2-dev smbclient fping libmysqlclient-dev libdbi-dev -y
wget https://github.com/nagios-plugins/nagios-plugins/releases/download/release-2.4.0/nagios-plugins-2.4.0.tar.gz
tar xzf nagios-plugins-2.4.0.tar.gz
cd nagios-plugins-2.4.0
./configure --with-nagios-user=nagios --with-nagios-group=nagios
make
make install
ls /usr/local/nagios/libexec/
systemctl restart nagios.service
a2enmod ssl 
a2ensite default-ssl.conf
systemctl restart apache2
systemctl restart nagios

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


