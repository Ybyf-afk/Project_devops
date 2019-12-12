resource "aws_internet_gateway" "devops-gw" {
    vpc_id = aws_vpc.devops.id

    tags = {
        Name = "devops-gw"
    }
}

resource "aws_route_table" "devops-rt" {
    vpc_id = aws_vpc.devops.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.devops-gw.id
    }
    
    tags = {
        Name = "devops-rt"
    }
}

resource "aws_route_table_association" "devops-rta" {
    subnet_id = aws_subnet.devops-public-1.id
    route_table_id = aws_route_table.devops-rt.id
}
