#!/bin/bash
# Updates programms
sudo yum update -y
# Installs Docker
sudo yum install docker -y
# Starts Docker and, makes it run automatically on start
sudo systemctl start docker
sudo systemctl enable docker
# sets AWS region
sudo aws configure set region eu-north-1
# changes permissions on docker config file, because I had some wierd errors and this fixed it
sudo chmod 666 /var/run/docker.sock
# running docker commands automatically as a sudo user
sudo usermod -aG docker ${USER}
# Logs in to AWS ECR
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 830121234761.dkr.ecr.eu-west-1.amazonaws.com
# Pulls latest jenkins image from ECR
docker pull 830121234761.dkr.ecr.eu-west-1.amazonaws.com/jenkins:latest
# Runs image on port 8080
docker run --name jenkins --rm -dit -p 8080:8080 830121234761.dkr.ecr.eu-west-1.amazonaws.com/jenkins:latest
# Installs git on machine
sudo yum install git -y
# makes dir. and downloads jenkins config files to that directory.
mkdir S3
aws s3 cp --recursive s3://endijsb ~/S3
# Changes permissions on all files downloaded
sudo chmod -R 777 ~/S3
# Copy files in jenkins docker container
docker cp ~/S3/jauns/Pipiline jenkins:/var/jenkins_home/jobs/ # JOBS
docker cp ~/S3/secrets jenkins:/var/jenkins_home/ # Credentials
docker cp ~/S3/secret.key jenkins:/var/jenkins_home/ # Credentials
docker cp ~/S3/credentials.xml jenkins:/var/jenkins_home/ # Credentials
# Restarts Jenkins
docker restart jenkins 