# bypass fingerprint check
# ssh into ec2
ssh -o  "StrictHostKeyChecking=no" ubuntu@63.34.171.104 <<EOF
# update and upgrade
sudo apt-get update -y
sudo apt-get upgrade -y

# install nginx
sudo apt-get install nginx -y
sudo sed -i '51s/.*/\t        proxy_pass http:\/\/localhost:3000;/' /etc/nginx/sites-enabled/default
sudo systemctl restart nginx
sudo systemctl enable nginx

# visit public ip to ensure nginx is running

EOF

# copy new code
rsync -avz -e "ssh -o StrictHostKeyChecking=no" app ubuntu@63.34.171.104:/home/ubuntu
rsync -avz -e "ssh -o StrictHostKeyChecking=no" environment ubuntu@63.34.171.104:/home/ubuntu

ssh -o  "StrictHostKeyChecking=no" ubuntu@63.34.171.104 <<EOF
# install node
curl -fsSL https://deb.nodesource.com/setup_10.x | sudo -E bash - && sudo apt-get install -y nodejs

# install npm
sudo apt install npm -y

# cd into app folder
cd app

# install npm in the app folder
npm install

# install pm2
sudo npm install pm2 -g

# stop any previously running versions of the app
pm2 kill

# start app
pm2 start app.js

EOF
