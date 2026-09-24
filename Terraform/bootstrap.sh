#!/bin/bash

sudo apt-get update -y

sudo apt install docker.io -y

sudo systemctl enable docker

sudo systemctl start docker

sudo usermod -aG docker ubuntu

docker --version

echo "EC2 bootstrap completed" > /home/ubuntu/bootstrap.txt