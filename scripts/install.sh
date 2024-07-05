#! /bin/bash
echo "Update linux"
sudo yum update -y
echo "installing ruby"
sudo yum install -y ruby wget
echo "Downloading codedeploy agent"
wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
echo "exceuting ownership"
chmod +x ./install
echo "Installing codedeploy agent"
sudo ./install auto
echo "Checking status"
sudo service codedeploy-agent status

echo "Install HTTP server"
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd