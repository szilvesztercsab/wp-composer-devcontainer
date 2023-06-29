#!/bin/bash -x

sudo chmod a+x \"$(pwd)\"
sudo rm -rf /var/www/html
sudo ln -s \"$(pwd)\" /var/www/html

composer install

echo "alias wp='$(pwd)/vendor/bin/wp'" >> ~/.bashrc

curl -O https://raw.githubusercontent.com/wp-cli/wp-cli/v2.6.0/utils/wp-completion.bash | tee ~/wp-completion.bash
echo "source ~/wp-completion.bash" >> ~/.bashrc

source ~/.bashrc

wp config create \
    --dbname=mariadb \
    --dbuser=mariadb \
    --dbhost=db \
    --dbpass=mariadb

wp db drop --yes

wp core install \
    --url="http://localhost:8080/wordpress" \
    --title="WP + Composer" \
    --admin_user=wp \
    --admin_password=wp \
    --admin_email=wp@wp.wp

# wp server
