data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "WebServer-sg" {
  name = "web-server-sg"
  ingress = [{
    description      = "SSH and SCP access port"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
    },
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "HTTPS server"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
  }]

  egress = [{
    description = "Allow all outbound traffic (replace with specific rules)"

    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }]
}

resource "aws_instance" "web-server" {
  ami                    = "ami-06c68f701d8090592"
  instance_type          = "t2.micro"
  key_name               = "fedora"
  vpc_security_group_ids = [aws_security_group.WebServer-sg.id]
  user_data              = file("../scripts/install.sh")
  tags = {
    Name = "WebServer"
  }
}



output "public_ip" {
  value = aws_instance.web-server.public_ip
}

