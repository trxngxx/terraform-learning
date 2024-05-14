resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
}

resource "aws_subnet" "rds_isolate" {
  count             = length(var.rds_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.rds_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
}
