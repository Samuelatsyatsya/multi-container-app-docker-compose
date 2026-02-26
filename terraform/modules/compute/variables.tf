variable "project_name" {}
variable "environment" {}
variable "suffix" {}

variable "vpc_id" {}

variable "private_subnet_ids" {
  type = list(string)
}

variable "app_security_group_id" {}
variable "app_target_group_arn" {}

variable "instance_type" {
  type = string
}

variable "ami_id" {}

variable "key_name" {}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "desired_capacity" {
  type = number
}

variable "app_port" {
  type = number
}

variable "db_endpoint" {}
variable "db_reader_endpoint" {}
variable "db_name" {}

variable "bastion_security_group_id" {}

variable "cpu_target_value" {
  type = number
}

variable "volume_size" {
  type = number
}

variable "volume_type" {
  type = string
}

variable "volume_encrypted" {
  type = bool
}

variable "health_check_grace_period" {
  type = number
}

variable "initial_lifecycle_heartbeat_timeout" {
  type = number
}

variable "enable_scheduled_scaling" {
  type = bool
}

variable "business_hours_min_size" {
  type = number
}

variable "business_hours_max_size" {
  type = number
}

variable "business_hours_desired_capacity" {
  type = number
}

variable "business_hours_cron" {
  type = string
}

variable "off_hours_min_size" {
  type = number
}

variable "off_hours_max_size" {
  type = number
}

variable "off_hours_desired_capacity" {
  type = number
}

variable "off_hours_cron" {
  type = string
}

variable "schedule_time_zone" {
  type = string
}
