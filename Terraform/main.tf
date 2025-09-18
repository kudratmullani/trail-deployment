resource "aws_instance" "Trail" {
  ami           = var.ami_id
  instance_type = var.instance_type
  count         = var.instance_count
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.trail-sg.id]

  tags = {
    Name = "Trail"
  }
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "trail-sg" {
  name   = "tools-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "api server"
  }

  ingress {
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
    description = "etcd"
  }

  ingress {
    from_port   = 10250
    to_port     = 10259
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
    description = "kubelet, kubeadm"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "trail-sg"
  }
}
