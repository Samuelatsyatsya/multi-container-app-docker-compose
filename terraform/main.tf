provider "aws" {
  region = var.aws_region
}

# Get current public IP from multiple sources
data "http" "my_ip_1" {
  url = var.ip_url1
}

data "http" "my_ip_2" {
  url = var.ip_url2
}

data "http" "my_ip_3" {
  url = var.ip_url3
}

# Use the first successful response
locals {
  # Try multiple sources, use first valid response
  my_public_ip = try(
    chomp(data.http.my_ip_1.response_body),
    chomp(data.http.my_ip_2.response_body),
    chomp(data.http.my_ip_3.response_body),
    "0.0.0.0" # Fallback if all fail
  )

  # Use provided CIDRs or auto-detected IP
  bastion_cidrs = length(var.bastion_allowed_cidrs) > 0 ? var.bastion_allowed_cidrs : ["${local.my_public_ip}/32"]
}


resource "random_id" "suffix" {
  byte_length = 4
}

module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones

  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  default_route_cidr    = var.default_route_cidr
}

module "security" {
  source = "./modules/security"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id

  app_port              = var.app_port
  alb_allowed_cidrs     = var.alb_allowed_cidrs
  bastion_allowed_cidrs = local.bastion_cidrs
  alb_http_port         = var.alb_http_port
  alb_https_port        = var.alb_https_port
  ssh_port              = var.ssh_port
  db_port               = var.db_port
  egress_cidr_blocks    = var.egress_cidr_blocks
}

# Add bastion module here
module "bastion" {
  source = "./modules/bastion"

  project_name = var.project_name
  environment  = var.environment
  suffix       = random_id.suffix.hex

  vpc_id                    = module.vpc.vpc_id
  public_subnet_ids         = module.vpc.public_subnet_ids
  bastion_security_group_id = module.security.bastion_security_group_id

  bastion_instance_type = var.bastion_instance_type
  bastion_ami_id        = var.bastion_ami_id
  key_name              = var.key_name
  volume_size           = var.volume_size
  volume_type           = var.volume_type
}

module "database" {
  source = "./modules/database"

  project_name = var.project_name
  environment  = var.environment
  suffix       = random_id.suffix.hex

  vpc_id               = module.vpc.vpc_id
  db_subnet_ids        = module.vpc.database_subnet_ids
  db_security_group_id = module.security.db_security_group_id

  db_instance_class = var.db_instance_class
  db_engine_version = var.db_engine_version
  db_name           = var.db_name
  db_username       = var.db_username

  multi_az            = var.db_multi_az
  create_read_replica = var.db_create_read_replica
  read_replica_count  = var.db_read_replica_count

  allocated_storage     = var.db_allocated_storage
  max_allocated_storage = var.db_max_allocated_storage
  storage_type          = var.db_storage_type
  storage_encrypted     = var.db_storage_encrypted

  backup_retention_period     = var.db_backup_retention_period
  backup_window               = var.db_backup_window
  maintenance_window          = var.db_maintenance_window
  db_engine                   = var.db_engine
  db_port                     = var.db_port
  publicly_accessible         = var.db_publicly_accessible
  skip_final_snapshot         = var.db_skip_final_snapshot
  deletion_protection         = var.db_deletion_protection
  replica_publicly_accessible = var.db_replica_publicly_accessible
  replica_skip_final_snapshot = var.db_replica_skip_final_snapshot
  db_password_length          = var.db_password_length
  db_password_special         = var.db_password_special
}

module "loadbalancer" {
  source = "./modules/loadbalancer"

  project_name = var.project_name
  environment  = var.environment
  suffix       = random_id.suffix.hex

  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.security.alb_security_group_id

  app_port                         = var.app_port
  health_check_path                = var.health_check_path
  certificate_arn                  = var.certificate_arn
  enable_https                     = var.enable_https
  enable_deletion_protection       = var.alb_enable_deletion_protection
  target_group_protocol            = var.target_group_protocol
  health_check_interval            = var.health_check_interval
  health_check_timeout             = var.health_check_timeout
  health_check_healthy_threshold   = var.health_check_healthy_threshold
  health_check_unhealthy_threshold = var.health_check_unhealthy_threshold
  health_check_matcher             = var.health_check_matcher
  http_listener_port               = var.http_listener_port
  enable_waf                       = var.enable_waf
  waf_rate_limit                   = var.waf_rate_limit
  blocked_ips                      = var.waf_blocked_ips
  enable_sqli_protection           = var.waf_enable_sqli
  enable_common_attacks_protection = var.waf_enable_common_rules
  waf_cloudwatch_metrics_enabled   = var.waf_cloudwatch_metrics_enabled
  waf_sampled_requests_enabled     = var.waf_sampled_requests_enabled
}


module "compute" {
  source = "./modules/compute"

  project_name = var.project_name
  environment  = var.environment
  suffix       = random_id.suffix.hex

  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  app_security_group_id = module.security.app_security_group_id
  app_target_group_arn  = module.loadbalancer.app_target_group_arn

  instance_type = var.instance_type
  ami_id        = var.ami_id
  key_name      = var.key_name

  min_size         = var.asg_min_size
  max_size         = var.asg_max_size
  desired_capacity = var.asg_desired_capacity

  app_port = var.app_port

  db_endpoint        = module.database.primary_endpoint
  db_reader_endpoint = module.database.reader_endpoint
  db_name            = module.database.database_name

  # Bastion security group for SSH access
  bastion_security_group_id = module.security.bastion_security_group_id

  # Mixed instance / spot options for cost optimization
  # on_demand_percentage      = var.on_demand_percentage
  # on_demand_base_capacity   = var.on_demand_base_capacity
  # spot_instance_pools       = var.spot_instance_pools

  cpu_target_value                    = var.cpu_target_value
  volume_size                         = var.compute_volume_size
  volume_type                         = var.compute_volume_type
  volume_encrypted                    = var.compute_volume_encrypted
  health_check_grace_period           = var.asg_health_check_grace_period
  initial_lifecycle_heartbeat_timeout = var.asg_initial_lifecycle_heartbeat_timeout
  enable_scheduled_scaling            = var.enable_scheduled_scaling
  business_hours_min_size             = var.business_hours_min_size
  business_hours_max_size             = var.business_hours_max_size
  business_hours_desired_capacity     = var.business_hours_desired_capacity
  business_hours_cron                 = var.business_hours_cron
  off_hours_min_size                  = var.off_hours_min_size
  off_hours_max_size                  = var.off_hours_max_size
  off_hours_desired_capacity          = var.off_hours_desired_capacity
  off_hours_cron                      = var.off_hours_cron
  schedule_time_zone                  = var.schedule_time_zone
  # instance_types            = var.instance_types
}




# Root main.tf
module "ecr" {
  source = "./modules/ecr"

  environment                    = var.environment
  aws_region                     = var.aws_region
  project_name                   = var.project_name
  backend_repository_name        = var.ecr_backend_repository_name
  frontend_repository_name       = var.ecr_frontend_repository_name
  project_tag                    = var.ecr_project_tag
  lifecycle_tag_prefixes         = var.ecr_tag_prefixes
  lifecycle_tagged_keep_count    = var.ecr_tagged_keep_count
  lifecycle_untagged_expire_days = var.ecr_untagged_expire_days
}
