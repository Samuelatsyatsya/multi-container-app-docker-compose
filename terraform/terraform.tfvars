aws_region   = "eu-central-1"
project_name = "three-tier-rps-game"
environment  = "dev"

vpc_cidr              = "10.0.0.0/16"
availability_zones    = ["eu-central-1a", "eu-central-1b"]
public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs  = ["10.0.3.0/24", "10.0.4.0/24"]
database_subnet_cidrs = ["10.0.5.0/24", "10.0.6.0/24"]
default_route_cidr    = "0.0.0.0/0"

app_port              = 80
alb_allowed_cidrs     = ["0.0.0.0/0"]
alb_http_port         = 80
alb_https_port        = 443
ssh_port              = 22
db_port               = 3306
egress_cidr_blocks    = ["0.0.0.0/0"]
bastion_allowed_cidrs = ["0.0.0.0/0"]
ip_url1               = "https://ifconfig.me/ip"
ip_url2               = "https://api.ipify.org"
ip_url3               = "https://icanhazip.com"

# Bastion configuration
bastion_instance_type = "t3.micro"
bastion_ami_id        = "ami-01f79b1e4a5c64257"
volume_size           = 20
volume_type           = "gp3"

# Database configuration
db_instance_class              = "db.t3.small"
db_engine                      = "mysql"
db_engine_version              = "8.4.7"
db_name                        = "gamedb"
db_username                    = "gameadmin"
db_multi_az                    = true
db_create_read_replica         = true
db_read_replica_count          = 1
db_allocated_storage           = 50
db_max_allocated_storage       = 200
db_storage_type                = "gp3"
db_storage_encrypted           = true
db_backup_retention_period     = 14
db_backup_window               = "02:00-03:00"
db_maintenance_window          = "sun:03:00-sun:04:00"
db_publicly_accessible         = false
db_skip_final_snapshot         = true
db_deletion_protection         = false
db_replica_publicly_accessible = false
db_replica_skip_final_snapshot = true
db_password_length             = 16
db_password_special            = false

# Load balancer configuration
health_check_path                = "/health"
certificate_arn                  = null
enable_https                     = true
alb_enable_deletion_protection   = false
target_group_protocol            = "HTTP"
health_check_interval            = 30
health_check_timeout             = 5
health_check_healthy_threshold   = 2
health_check_unhealthy_threshold = 2
health_check_matcher             = "200"
http_listener_port               = 80

# Compute configuration
instance_type                           = "t3.micro"
ami_id                                  = "ami-01f79b1e4a5c64257"
key_name                                = "rps-game-keypair"
asg_min_size                            = 2
asg_max_size                            = 4
asg_desired_capacity                    = 2
cpu_target_value                        = 70.0
compute_volume_size                     = 20
compute_volume_type                     = "gp3"
compute_volume_encrypted                = true
asg_health_check_grace_period           = 300
asg_initial_lifecycle_heartbeat_timeout = 300
enable_scheduled_scaling                = false
business_hours_min_size                 = 3
business_hours_max_size                 = 12
business_hours_desired_capacity         = 4
business_hours_cron                     = "0 9 * * MON-FRI"
off_hours_min_size                      = 1
off_hours_max_size                      = 4
off_hours_desired_capacity              = 2
off_hours_cron                          = "0 18 * * MON-FRI"
schedule_time_zone                      = "UTC"

estimated_savings = "60-70%"

# WAF configuration
enable_waf                     = true
waf_rate_limit                 = 5000
waf_enable_sqli                = true
waf_enable_common_rules        = true
waf_blocked_ips                = []
waf_cloudwatch_metrics_enabled = false
waf_sampled_requests_enabled   = false

# ECR configuration
ecr_backend_repository_name  = "rps-backend"
ecr_frontend_repository_name = "rps-frontend"
ecr_project_tag              = "rock-paper-scissors"
ecr_tag_prefixes             = ["v", "prod", "staging"]
ecr_tagged_keep_count        = 30
ecr_untagged_expire_days     = 7
