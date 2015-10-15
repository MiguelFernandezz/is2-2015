
sudo service apache2 stop
echo "Borrando archivos de /var/www/taguato ..."
sudo rm -R /var/www/taguato/
echo "Copiando archivos de ~/git/taguato/ /var/www/taguato ..."
sudo cp -R ~/git/taguato/ /var/www/
sudo chown -R www-data /var/www/taguato/taguato/media
sudo chown -R www-data /var/www/taguato/static
echo "Copiando archivo de configuracion de apache: taguato.conf ..."
sudo cp ~/git/taguato/taguato.conf /etc/apache2/sites-enabled/
sudo service apache2 restart 
