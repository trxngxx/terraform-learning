module "vpc" {
  source = "../../modules/common"
  vpc_cidr         = var.vpc_cidr
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  rds_subnets      = var.rds_subnets
  availability_zones = var.availability_zones
}

module "internet_gateway" {
  source = "../../modules/common"
  vpc_id = module.vpc.vpc_id
}

module "nat_gateway" {
  source = "../../modules/common"
  vpc_id          = module.vpc.vpc_id
  public_subnet_id = element(module.vpc.public_subnets, 0)
}

module "route_tables" {
  source = "../../modules/common"
  vpc_id           = module.vpc.vpc_id
  igw_id           = module.internet_gateway.igw_id
  nat_gateway_id   = module.nat_gateway.nat_id
  public_subnet_ids = module.vpc.public_subnets
  private_subnet_ids = module.vpc.private_subnets
}

module "instances" {
  source = "../../modules/common"
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnets
  private_subnet_ids  = module.vpc.private_subnets
  key_name            = var.key_name
}

module "rds" {
  source = "../../modules/common"
  rds_subnet_ids = module.vpc.rds_subnets
}
