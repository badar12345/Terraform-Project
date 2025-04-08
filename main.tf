module "network" {
  source              = "./modules/network"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  environment         = var.environment
}

module "compute" {
  source              = "./modules/compute"
  vpc_id              = module.network.vpc_id
  public_subnet_ids   = module.network.public_subnet_ids
  private_subnet_ids  = module.network.private_subnet_ids
  proxy_sg_id         = module.network.proxy_sg_id
  backend_sg_id       = module.network.backend_sg_id
  environment         = var.environment
}

module "loadbalancer" {
  source              = "./modules/loadbalancer"
  vpc_id              = module.network.vpc_id
  public_subnet_ids   = module.network.public_subnet_ids
  private_subnet_ids  = module.network.private_subnet_ids
  public_lb_sg_id     = module.network.public_lb_sg_id
  private_lb_sg_id    = module.network.private_lb_sg_id
  backend_instance_ids = module.compute.backend_instance_ids
  environment         = var.environment
}

resource "local_file" "all_ips" {
  filename = "all-ips.txt"
  content  = join("\n", concat(
    [for idx, ip in module.compute.proxy_public_ips : "public-ip${idx + 1}  ${ip}"],
    [for idx, ip in module.compute.backend_private_ips : "private-ip${idx + 1}  ${ip}"]
  ))
}