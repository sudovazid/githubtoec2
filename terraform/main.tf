provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

resource "aws_instance" "web_server" {
  ami           = "ami-06c68f701d8090592"  # Amazon Linux 2 AMI ID (replace with the latest AMI ID for your region)
  instance_type = "t2.micro"
  key_name      = "fedora"  # Replace with your key pair name

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "WebServer"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow inbound traffic for web server"

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}