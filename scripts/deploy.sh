#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Update the instance
sudo yum update -y

# Ensure Apache is installed and running
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

# Copy the website files to the Apache document root
sudo cp -R ./* /var/www/html/

# Set proper permissions
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html

echo "Deployment completed successfully!"