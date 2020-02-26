#!/bin/sh

BIN_DIR="/vagrant/bin"
echo "Starting installation common packages"
sudo apt install -y curl git python3-pip python3-venv tmux >/dev/null 2>&1
echo "Setup python3 as a python default"
update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1

echo "Setup and download nodejs packages"
curl -sL https://deb.nodesource.com/setup_13.x | bash - >/dev/null 2>&1
sudo apt update > /dev/null 2>&1

echo "Starting installation "
sudo apt install nodejs -y > /dev/null 2>&1

echo "$BIN_DIR/download_repos.sh" > /home/vagrant/init.sh > /dev/null 2>&1
echo "$BIN_DIR/devel.sh" >> /home/vagrant/init.sh > /dev/null 2>&1
chmod +x /home/vagrant/init.sh > /dev/null 2>&1

echo "You need to start init script"
echo "Example: \n
      vagrant ssh \n
      ./init.sh"
