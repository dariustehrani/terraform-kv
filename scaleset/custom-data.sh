#!/bin/bash

set -e
exec > >(tee /var/log/custom-data.log|logger -t custom-data -s 2>/dev/console) 2>&1
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo apt-get autoremove -y
sudo reboot