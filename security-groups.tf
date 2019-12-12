# Security groups required for devops VPC
resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  description = "Allows inbound SSH traffic."
  
  vpc_id = aws_vpc.devops.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-allow-ssh"
  }
}

resource "aws_security_group" "allow_tomcat" {
  name = "allow_tomcat"
  description = "Allow TOMCAT inbound traffic."

  vpc_id = aws_vpc.devops.id

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-allow-tomcat"
  }
}

resource "aws_security_group" "devops-alb" {
  name = "devops-alb"
  description = "Security group for ALB."

  vpc_id = aws_vpc.devops.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ecs-instance-devops" {
  name = "ecs-instance-devops"
  description = "Security group for ALB."

  vpc_id = aws_vpc.devops.id

  ingress {
    from_port = 32768
    to_port = 61000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}