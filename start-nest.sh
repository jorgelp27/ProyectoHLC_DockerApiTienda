#!/bin/bash

set -e

bash /root/start.sh

echo "$USUARIO, $PROYECTO, $DB_NAME" > /home/datos_entry.txt



config_git(){
    rm -rf /var/www/html/${PROYECTO}
    mkdir /var/www/html/${PROYECTO}
    cd /var/www/html/${PROYECTO}
    rm -rf .git
    
    git config --global init.defaultBranch main
    git config --global http.sslverify false
    git init
    git remote add origin ${URL_GIT}
    git branch -m main
    git pull origin main
    cd /var/www/html/${PROYECTO}/api-tienda
    
}


config_nest(){
    
    echo "DB_HOST=${DB_HOST}" > ./.env
    echo "DB_PORT=5432" >> ./.env
    echo "DB_USER=${DB_USER}" >> ./.env
    echo "DB_PASS=${DB_PASS}" >> ./.env
    echo "DB_NAME=${DB_NAME}" >>./.env
    echo "URL_GIT=${URL_GIT}" >>./.env
    
    # npm i -g @nest/cli

    npm install --force && npm run start:dev
   
}

main(){
    
    config_git
    config_nest
    tail -f /dev/null 
}
main
