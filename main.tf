resource "aws_vpc" "network" {
    cidr_block = "172.16.0.0/16"

    tags = {
      "Enviroment" = "Test"
    }
  
}

resource "aws_subnet" "subnet" {
    vpc_id = aws_vpc.network.id
    cidr_block = "172.16.10.0/24"
    availability_zone = var.az

    tags = {
        "Environment" = "Test"
    }

}

resource "aws_instance" "ec2_test" {
    instance_type = "t2.micro"
    ami = var.ami
    availability_zone = var.az
    subnet_id = aws_subnet.subnet.id

    metadata_options {
      http_tokens = "required"
    }

    tags = {
      "Environment" = "Test"
    }
  
}