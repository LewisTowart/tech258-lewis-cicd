#!/bin/bash

# Update
echo updating...
sudo apt update -y
echo done!

# Upgrade
echo upgrading
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
echo finished upgrading

# install mongo db 7.0.6

# installing these packages
sudo apt-get install gnupg curl

sudo rm -f /usr/share/keyrings/mongodb-server-7.0.gpg
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

sudo apt-get update

# specifying the 7.0.6 version

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mongodb-org=7.0.6 mongodb-org-database=7.0.6 mongodb-org-server=7.0.6 mongodb-mongosh=2.2.4 mongodb-org-mongos=7.0.6 mongodb-org-tools=7.0.6

# sudo nano /etc/mongod.conf for manual edit

# Replace the bindIp setting with 0.0.0.0
sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf

# restart mongo db (or start if not started already)

sudo systemctl restart mongod

# enable mongo db

sudo systemctl enable mongod

# be careful of these keys, they will go out of date
# sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927
# echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# sudo apt-get update -y
# sudo apt-get upgrade -y

# sudo apt-get install mongodb-org=3.2.20 -y
# sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20

# remoe the default .conf and replace with our configuration
# sudo rm /etc/mongod.conf
# sudo ln -s /home/ubuntu/environment/mongod.conf /etc/mongod.conf

# if mongo is is set up correctly these will be successful
# sudo systemctl restart mongod
# sudo systemctl enable mongod
