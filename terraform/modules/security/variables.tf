variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {}

variable "app_port" {
  type = number
}

variable "alb_allowed_cidrs" {
  type = list(string)
}

variable "bastion_allowed_cidrs" {
  type = list(string)
}

variable "alb_http_port" {
  type = number
}

variable "alb_https_port" {
  type = number
}

variable "ssh_port" {
  type = number
}

variable "db_port" {
  type = number
}

variable "egress_cidr_blocks" {
  type = list(string)
}
