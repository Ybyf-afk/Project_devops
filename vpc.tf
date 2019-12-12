# Network for our devops setup
resource "aws_vpc" "devops" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    
    tags = {
      Name = "devops"
    }
}

# Subnets for devops network
resource "aws_subnet" "devops-public-1" {
    vpc_id = aws_vpc.devops.id
    availability_zone = "eu-west-2a"
    
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"

    tags = {
       Name = "devops-public-1"
    }
}

resource "aws_subnet" "devops-public-2" {
    vpc_id = aws_vpc.devops.id
    availability_zone = "eu-west-2b"

    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"

    tags = {
        Name = "devops-public-2"
    }
}

