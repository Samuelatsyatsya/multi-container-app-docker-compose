variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
}

variable "project_name" {
  type        = string
  description = "Name of the project for resource naming"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, staging, prod)"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones for multi-AZ deployment"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
}

variable "database_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for database subnets"
}

variable "default_route_cidr" {
  type        = string
  description = "Default route destination CIDR for internet/NAT routes"
}

variable "app_port" {
  type        = number
  description = "Port that application listens on"
}

variable "alb_allowed_cidrs" {
  type        = list(string)
  description = "CIDR blocks allowed to access ALB"
}

variable "alb_http_port" {
  type        = number
  description = "ALB HTTP ingress port"
}

variable "alb_https_port" {
  type        = number
  description = "ALB HTTPS ingress port"
}

variable "ssh_port" {
  type        = number
  description = "SSH port for bastion/app access"
}

variable "db_port" {
  type        = number
  description = "Database port"
}

variable "egress_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks allowed for outbound traffic"
}

variable "ip_url1" {
  type        = string
  description = "First site to detect admin public IP"
}

variable "ip_url2" {
  type        = string
  description = "Second site to detect admin public IP"
}

variable "ip_url3" {
  type        = string
  description = "Third site to detect admin public IP"
}

variable "bastion_allowed_cidrs" {
  type        = list(string)
  description = "CIDR blocks allowed SSH access to bastion"
}

variable "bastion_instance_type" {
  type        = string
  description = "EC2 instance type for bastion host"
}

variable "bastion_ami_id" {
  type        = string
  description = "AMI ID for bastion host"
}

variable "volume_size" {
  type        = number
  description = "Bastion root volume size in GB"
}

variable "volume_type" {
  type        = string
  description = "Bastion root volume type"
}

variable "db_instance_class" {
  type        = string
  description = "RDS instance class"
}

variable "db_engine" {
  type        = string
  description = "Database engine"
}

variable "db_engine_version" {
  type        = string
  description = "Database engine version"
}

variable "db_name" {
  type        = string
  description = "Name of the database"
}

variable "db_username" {
  type        = string
  description = "Master username for database"
}

variable "db_multi_az" {
  type        = bool
  description = "Enable Multi-AZ deployment for RDS"
}

variable "db_create_read_replica" {
  type        = bool
  description = "Create read replica for database"
}

variable "db_read_replica_count" {
  type        = number
  description = "Number of read replicas to create"
}

variable "db_allocated_storage" {
  type        = number
  description = "Initial storage allocated to database in GB"
}

variable "db_max_allocated_storage" {
  type        = number
  description = "Maximum storage database can auto-scale to in GB"
}

variable "db_storage_type" {
  type        = string
  description = "Database storage type (e.g. gp3)"
}

variable "db_storage_encrypted" {
  type        = bool
  description = "Enable encryption for database storage"
}

variable "db_backup_retention_period" {
  type        = number
  description = "Number of days to keep automated backups"
}

variable "db_backup_window" {
  type        = string
  description = "Time window for automated backups"
}

variable "db_maintenance_window" {
  type        = string
  description = "Time window for database maintenance"
}

variable "db_publicly_accessible" {
  type        = bool
  description = "Whether primary DB should be publicly accessible"
}

variable "db_skip_final_snapshot" {
  type        = bool
  description = "Skip final snapshot on DB deletion"
}

variable "db_deletion_protection" {
  type        = bool
  description = "Enable deletion protection on primary DB"
}

variable "db_replica_publicly_accessible" {
  type        = bool
  description = "Whether read replica should be publicly accessible"
}

variable "db_replica_skip_final_snapshot" {
  type        = bool
  description = "Skip final snapshot on read replica deletion"
}

variable "db_password_length" {
  type        = number
  description = "Generated DB password length"
}

variable "db_password_special" {
  type        = bool
  description = "Allow special characters in generated DB password"
}

variable "health_check_path" {
  type        = string
  description = "Path for ALB health checks"
}

variable "certificate_arn" {
  type        = string
  description = "ARN of SSL certificate for HTTPS"
}

variable "enable_https" {
  type        = bool
  description = "Enable HTTPS listener on ALB"
}

variable "alb_enable_deletion_protection" {
  type        = bool
  description = "Enable deletion protection on ALB"
}

variable "target_group_protocol" {
  type        = string
  description = "Protocol for target group"
}

variable "health_check_interval" {
  type        = number
  description = "ALB health check interval in seconds"
}

variable "health_check_timeout" {
  type        = number
  description = "ALB health check timeout in seconds"
}

variable "health_check_healthy_threshold" {
  type        = number
  description = "Healthy threshold count for target health checks"
}

variable "health_check_unhealthy_threshold" {
  type        = number
  description = "Unhealthy threshold count for target health checks"
}

variable "health_check_matcher" {
  type        = string
  description = "HTTP matcher for ALB health checks"
}

variable "http_listener_port" {
  type        = number
  description = "HTTP listener port"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for app servers"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for app instances"
}

variable "key_name" {
  type        = string
  description = "SSH key pair name for instances"
}

variable "asg_min_size" {
  type        = number
  description = "Minimum number of instances in ASG"
}

variable "asg_max_size" {
  type        = number
  description = "Maximum number of instances in ASG"
}

variable "asg_desired_capacity" {
  type        = number
  description = "Desired number of instances in ASG"
}

variable "cpu_target_value" {
  type        = number
  description = "CPU percentage to maintain with target tracking"
}

variable "compute_volume_size" {
  type        = number
  description = "App instance root volume size in GB"
}

variable "compute_volume_type" {
  type        = string
  description = "App instance root volume type"
}

variable "compute_volume_encrypted" {
  type        = bool
  description = "Enable encryption on app instance root volume"
}

variable "asg_health_check_grace_period" {
  type        = number
  description = "ASG health check grace period in seconds"
}

variable "asg_initial_lifecycle_heartbeat_timeout" {
  type        = number
  description = "ASG initial lifecycle hook heartbeat timeout in seconds"
}

variable "enable_scheduled_scaling" {
  type        = bool
  description = "Enable scheduled scaling policy"
}

variable "business_hours_min_size" {
  type        = number
  description = "Minimum ASG size during business hours"
}

variable "business_hours_max_size" {
  type        = number
  description = "Maximum ASG size during business hours"
}

variable "business_hours_desired_capacity" {
  type        = number
  description = "Desired ASG capacity during business hours"
}

variable "business_hours_cron" {
  type        = string
  description = "Cron expression for business hours scale up"
}

variable "off_hours_min_size" {
  type        = number
  description = "Minimum ASG size during off hours"
}

variable "off_hours_max_size" {
  type        = number
  description = "Maximum ASG size during off hours"
}

variable "off_hours_desired_capacity" {
  type        = number
  description = "Desired ASG capacity during off hours"
}

variable "off_hours_cron" {
  type        = string
  description = "Cron expression for off hours scale down"
}

variable "schedule_time_zone" {
  type        = string
  description = "Time zone for scheduled scaling"
}

variable "estimated_savings" {
  type        = string
  description = "Cost savings estimate from optimization strategy"
}

variable "enable_waf" {
  type        = bool
  description = "Enable Web Application Firewall protection"
}

variable "waf_rate_limit" {
  type        = number
  description = "Max requests per 5 minutes per IP"
}

variable "waf_blocked_ips" {
  type        = list(string)
  description = "Manually blocked IP addresses"
}

variable "waf_enable_sqli" {
  type        = bool
  description = "Enable SQL injection protection"
}

variable "waf_enable_common_rules" {
  type        = bool
  description = "Enable common attacks protection"
}

variable "waf_cloudwatch_metrics_enabled" {
  type        = bool
  description = "Enable CloudWatch metrics for WAF"
}

variable "waf_sampled_requests_enabled" {
  type        = bool
  description = "Enable sampled requests for WAF"
}

variable "ecr_backend_repository_name" {
  type        = string
  description = "Backend ECR repository name"
}

variable "ecr_frontend_repository_name" {
  type        = string
  description = "Frontend ECR repository name"
}

variable "ecr_project_tag" {
  type        = string
  description = "Project tag value for ECR repositories"
}

variable "ecr_tag_prefixes" {
  type        = list(string)
  description = "Tag prefixes retained by ECR lifecycle policy"
}

variable "ecr_tagged_keep_count" {
  type        = number
  description = "Number of tagged images to keep"
}

variable "ecr_untagged_expire_days" {
  type        = number
  description = "Age threshold for expiring untagged images"
}
