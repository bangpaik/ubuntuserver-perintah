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
echo " [1] Install PHP 7.4, dan menyalin phpinfo.php ke /var/www/html dan      ";
echo "      install MySQL Server                                         ";
echo " [2] Install phpmyadmin 5.0.4 (Kompatible dengan PHP 7.4)         ";
echo " [3] Amankan dari PHP Shell(/etc/apache2/php7.4/apache/php.ini)    ";
echo " [4] Exit                                                          ";
echo "-------------------------------------------------------------------";
read -p " Masukkan Nomor Pilihan Anda antara [1 s.d 4] : " choice;
echo "";
case $choice in

1)  sudo apt-get update
    sudo apt -y install software-properties-common
    sudo add-apt-repository ppa:ondrej/php 
    sudo apt-get update
    sudo apt -y install php7.4
    sudo cp support/phpinfo.php /var/www/html
    sudo apt install mysql-server
    echo -n "Masukkan password root yang akan dibuat : "
    read passmysql
    sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$passmysql';" 
    sudo clear
    service apache2 restart
    read -p "Tekan enter untuk restart, setelah restart cek phpinfo.php di browser, bisa dipanggil lewat ip address/phpinfo.php"
    ;;

2) sudo apt install phpmyadmin
    sudo mv /usr/share/phpmyadmin/ /usr/share/phpmyadmin.bak
    sudo mkdir /usr/share/phpmyadmin/
    sudo wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
    sudo tar xzf phpMyAdmin-5.0.4-all-languages.tar.gz
    sudo mv phpMyAdmin-5.0.4-all-languages/* /usr/share/phpmyadmin
    cp support/vendor_config.php /usr/share/phpmyadmin/libraries/
    ;;



3) read -p "Apakah anda yakin menggunakan apache server dengan PHP 7.4? y/n :" -n 1 -r
    echo  ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
    if [ -z "$(ls -l /etc/php/7.4/apache2/php.ini)" ]; then
    echo "File php.ini tidak ada di /etc/php/7.4/apache2/php.ini"
    else
    sudo cp /etc/php/7.4/apache2/php.ini /etc/php/7.4/apache2/phpini.backup
    sudo cp support/php.ini /etc/php/7.4/apache2
    sudo service apache2 restart
    fi
    fi
    ;;

4) exit
    ;;
*)    echo "Menu tidak ditemukan"
esac
echo ""
echo "Script untuk mendukung otomatisasi apache server di Ubuntu Server"
echo ""
echo -n "Kembali ke menu? [y/n]: ";
read again;
while [[ $again != 'Y' ]] && [[ $again != 'y' ]] && [[ $again != 'N' ]] && [[ $again != 'n' ]];
do
echo "Inputan yang anda pilih tidak ada di menu";
echo -n "Kembali ke menu? [y/n]: ";
read again;
done
done
