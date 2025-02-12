provider "aws" {
  region = "us-east-1"
}
# Use dafult VPC and create a subnet based on it [neccessary for EC2 instance]
data "aws_vpc" "default" {
  default = true
}
resource "aws_subnet" "main" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = cidrsubnet(data.aws_vpc.default.cidr_block, 4, 1)
  tags = {
    Name = "main"
  }
}


#Create a key pair locally and use it on AWS [To be able to SSH into the instance]
resource "tls_private_key" "jenkins_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# save the key pair in a local file
resource "local_file" "jenkins_key" {
  content  = tls_private_key.jenkins_key.private_key_pem
  filename = "./key/jenkins_key"
}
resource "local_file" "jenkins_key_pub" {
  content  = tls_private_key.jenkins_key.public_key_openssh
  filename = "./key/jenkins_key.pub"
}
resource "aws_key_pair" "jenkins_key" {
  key_name   = var.key_name
  public_key = tls_private_key.jenkins_key.public_key_openssh
}


# extract the latest Ubuntu 20.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

########################################################################
# Create a security group to allow All ports from the same security group
resource "aws_security_group" "jenkins" {
  name        = "jenkins-sg"
  description = "Allow all ports from the same security group"
  vpc_id      = data.aws_vpc.default.id
  tags = {
    Name = "jenkins-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "jenkins" {
  description       = "Allow all ports from the same security group"
  security_group_id = aws_security_group.jenkins.id
  cidr_ipv4         = data.aws_vpc.default.cidr_block
  ip_protocol       = -1
}
resource "aws_vpc_security_group_egress_rule" "jenkins" {
  description       = "Allow all ports from the same security group"
  security_group_id = aws_security_group.jenkins.id
  cidr_ipv4         = data.aws_vpc.default.cidr_block
  ip_protocol       = -1
}
###############################################################
resource "aws_instance" "jenkins" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.jenkins_key.key_name
  security_groups             = [aws_security_group.jenkins.id]
  subnet_id                   = aws_subnet.main.id
  associate_public_ip_address = true
  tags = {
    Name = "jenkins-server"
  }
    lifecycle {
    ignore_changes = [security_groups]
  }

}


