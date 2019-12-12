#!/bin/bash

sudo yum install -y java-1.8.0
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install -y jenkins
sudo service jenkins start

echo "Waiting for Jenkins to generate configuration files..."
sleep 60
sudo cat /var/lib/jenkins/secrets/initialAdminPassword