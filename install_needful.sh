#! /bin/bash

#install git
sudo yum update -y
sudo yum install git -y

#installing kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.17/2023-11-14/bin/linux/amd64/kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.17/2023-11-14/bin/linux/amd64/kubectl.sha256

openssl sha1 -sha256 kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc


#installing aws-cli latest
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
sudo ln -s /usr/local/bin/aws /usr/bin/aws
