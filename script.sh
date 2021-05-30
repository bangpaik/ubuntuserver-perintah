#!/bin/bash
#bangpaik

again='y'
while [[ $again == 'Y' ]] || [[ $again == 'y' ]];
do
clear
echo "-------------------------------------------------------------------";
echo " Script untuk mendukung otomatisasi apache server di Ubuntu Server ";
echo "-------------------------------------------------------------------";
echo " Instalasi                                                         ";
echo " [1] Install Apache2 , MySQL, php7.3 dan menyalin phpinfo.php ke /var/www/html dan      ";
echo " [2] Install phpmyadmin 5.0.4                                      ";
echo " [3] Exit                                                          ";
echo "-------------------------------------------------------------------";
read -p " Masukkan Nomor Pilihan Anda antara [1 s.d 3] : " choice;
echo "";
case $choice in

1)  sudo apt-get update
    sudo apt -y install apache2
    sudo apt -y install software-properties-common
    sudo add-apt-repository ppa:ondrej/php 
    sudo apt-get update
    deb http://ppa.launchpad.net/ondrej/php/ubuntu bionic main
    deb-src http://ppa.launchpad.net/ondrej/php/ubuntu bionic main
    sudo apt-get install php7.3
    sudo cp phpinfo.php /var/www/html
    service apache2 restart
    sudo apt install mysql-server
    echo -n "Masukkan password root yang akan dibuat : "
    read passmysql
    sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$passmysql';" 
    sudo clear
    service apache2 restart
    read -p "Instalasi Sukses, Silahkan cek browser dengan memasukkan IP server"
    ;;

2) sudo apt install phpmyadmin
    sudo mv /usr/share/phpmyadmin/ /usr/share/phpmyadmin.bak
    sudo mkdir /usr/share/phpmyadmin/
    sudo wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
    sudo tar xzf phpMyAdmin-5.0.4-all-languages.tar.gz
    sudo mv phpMyAdmin-5.0.4-all-languages/* /usr/share/phpmyadmin
    cp support/vendor_config.php /usr/share/phpmyadmin/libraries/
    ;;



3) exit
    ;;
*)    echo "Menu tidak ditemukan"
esac
echo ""
echo "Script mudah instalasi LAMP di Ubuntu Server"
echo ""
echo -n "Kembali ke menu? [y/n]: ";
read again;
while [[ $again != 'Y' ]] && [[ $again != 'y' ]] && [[ $again != 'N' ]] && [[ $again != 'n' ]];
do
echo "Data tidak ditemukan";
echo -n "Kembali ke menu? [y/n]: ";
read again;
done
done
