variable "ami_id" {
    default = "ami-042b4708b1d05f512"
    type = string
}

variable "aws_instance_type" {
  default = "t3.micro"
}

variable "instance_storage" {
    default = 10
  
}