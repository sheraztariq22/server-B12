provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
}

resource "aws_security_group" "server_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 5000
    to_port     = 5000
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

resource "aws_instance" "server" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.main.id
  security_groups = [aws_security_group.server_sg.name]

  tags = {
    Name = "ServerInstance"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Installing Docker..."
              apt-get update
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker
              echo "Docker installed."
              EOF
}

output "server_public_ip" {
  value = aws_instance.server.public_ip
}
