#!/bin/bash -x

composer install

echo "alias wp='$(pwd)/vendor/bin/wp'" >> "${HOME}/.bashrc"

curl -O https://raw.githubusercontent.com/wp-cli/wp-cli/v2.6.0/utils/wp-completion.bash | tee wp-completion.bash
cat wp-completion.bash >> "${HOME}/.bashrc"
rm wp-completion.bash

vendor/bin/wp config create \
    --dbname=mariadb \
    --dbuser=mariadb \
    --dbhost=db \
    --dbpass=mariadb

vendor/bin/wp db drop --yes || true
vendor/bin/wp db create

vendor/bin/wp core install \
    --url="http://localhost:8080" \
    --title="WP + Composer + Dev Containers = ♥" \
    --admin_user=wp \
    --admin_password=wp \
    --admin_email=wp@wp.wp

# vendor/bin/wp server --host=0.0.0.0 --port=8080
