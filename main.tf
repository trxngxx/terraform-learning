provider "aws" {
  region = "us-east-1"  # Đặt region bạn mong muốn
}

# Tạo VPC
resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16"
}

# Tạo Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# Tạo Public Subnet 1
resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.16.0.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

# Tạo Public Subnet 2
resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
}

# Tạo Private Subnet 1
resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.16.2.0/24"
  availability_zone = "us-east-1a"
}

# Tạo Private Subnet 2
resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.16.3.0/24"
  availability_zone = "us-east-1b"
}

# Tạo RDS Isolate Subnet 1
resource "aws_subnet" "rds_isolate1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.16.4.0/24"
  availability_zone = "us-east-1a"
}

# Tạo RDS Isolate Subnet 2
resource "aws_subnet" "rds_isolate2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.16.5.0/24"
  availability_zone = "us-east-1b"
}

# Tạo NAT Gateway cho Public Subnet 1
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public1.id
}

# Tạo Route Table cho Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

# Tạo Route Table cho Private Subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private.id
}

# Tạo Security Groups
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

# Tạo Bastion Host
resource "aws_instance" "bastion1" {
  ami           = "ami-0c55b159cbfafe1f0"  # Đặt AMI ID phù hợp
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public1.id
  security_groups = [aws_security_group.bastion_sg.name]
  key_name      = "your-key-name"  # Đặt tên key pair phù hợp
}

resource "aws_instance" "bastion2" {
  ami           = "ami-0c55b159cbfafe1f0"  # Đặt AMI ID phù hợp
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public2.id
  security_groups = [aws_security_group.bastion_sg.name]
  key_name      = "your-key-name"  # Đặt tên key pair phù hợp
}

# Tạo các instance cho Kubernetes cluster (ví dụ đơn giản)
resource "aws_instance" "k8s_master" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.private1.id
  key_name      = "your-key-name"
}

resource "aws_instance" "k8s_worker1" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.private1.id
  key_name      = "your-key-name"
}

resource "aws_instance" "k8s_worker2" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.private2.id
  key_name      = "your-key-name"
}

# Tạo RDS instance
resource "aws_db_instance" "rds" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "admin"
  password             = "yourpassword"
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = [aws_subnet.rds_isolate1.id, aws_subnet.rds_isolate2.id]
}
