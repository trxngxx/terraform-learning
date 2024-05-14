resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  description = "Allow SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "bastion1" {
  ami           = "ami-0c55b159cbfafe1f0"  # Đặt AMI ID phù hợp
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public[0].id
  security_groups = [aws_security_group.bastion_sg.name]
  key_name      = var.key_name
}

resource "aws_instance" "bastion2" {
  ami           = "ami-0c55b159cbfafe1f0"  # Đặt AMI ID phù hợp
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public[1].id
  security_groups = [aws_security_group.bastion_sg.name]
  key_name      = var.key_name
}

resource "aws_instance" "k8s_master" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.private[0].id
  key_name      = var.key_name
}

resource "aws_instance" "k8s_worker1" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.private[0].id
  key_name      = var.key_name
}

resource "aws_instance" "k8s_worker2" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.private[1].id
  key_name      = var.key_name
}
