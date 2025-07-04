# key to connect to ec2 instance

resource "aws_key_pair" "myweb_key" {
  key_name = "myweb_key"
  public_key = file("myweb_key.pub")
}

# default vpc for instance

resource "aws_default_vpc" "myweb_vpc" {
  
}

# security group for instance

resource "aws_security_group" "myweb_sg" {
    
    name = "myweb_sg"
    vpc_id = aws_default_vpc.myweb_vpc.id
    description = "security group for mywebsite "
    tags = {
      Name = "myweb_sg"
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "http port open"
    }
    
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "myweb" {
    
    key_name = aws_key_pair.myweb_key.key_name
    security_groups = [aws_security_group.myweb_sg.name]
    ami = var.ami_id
    instance_type = var.aws_instance_type
    
    root_block_device {
      volume_size = var.instance_storage
      volume_type = "gp3"
    }
    
    tags = {
      Name = "myweb"
    }
    
}