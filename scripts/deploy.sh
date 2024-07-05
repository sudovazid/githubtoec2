#!/bin/bash
scp -i ../keys/fedora.pub -r website/* ec2-user@$EC2_PUBLIC_IP:/var/www/html

ssh -i ../keys/fedora.pub ec2-user@$EC2_PUBLIC_IP "sudo systemctl restart httpd"

echo "Deployment completed successfully !!!"