variable "project_name" {}
variable "environment" {}
variable "suffix" {}

variable "vpc_id" {}

variable "public_subnet_ids" {
  type = list(string)
}

variable "alb_security_group_id" {}

variable "app_port" {
  type = number
}

variable "health_check_path" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "enable_https" {
  type = bool
}

variable "enable_deletion_protection" {
  type = bool
}

variable "target_group_protocol" {
  type = string
}

variable "health_check_interval" {
  type = number
}

variable "health_check_timeout" {
  type = number
}

variable "health_check_healthy_threshold" {
  type = number
}

variable "health_check_unhealthy_threshold" {
  type = number
}

variable "health_check_matcher" {
  type = string
}

variable "http_listener_port" {
  type = number
}

variable "alb_https_port" {
  type = number
}

# WAF configuration
variable "enable_waf" {
  type = bool
}

variable "waf_rate_limit" {
  type = number
}

variable "blocked_ips" {
  type = list(string)
}

variable "enable_sqli_protection" {
  type = bool
}

variable "enable_common_attacks_protection" {
  type = bool
}

variable "waf_cloudwatch_metrics_enabled" {
  type = bool
}

variable "waf_sampled_requests_enabled" {
  type = bool
}
