variable "project_name" {}
variable "environment" {}
variable "suffix" {}

variable "vpc_id" {}

variable "db_subnet_ids" {
  type = list(string)
}

variable "db_security_group_id" {}

variable "db_instance_class" {
  type = string
}

variable "db_engine" {
  type = string
}

variable "db_engine_version" {
  type = string
}

variable "db_name" {}
variable "db_username" {}

variable "db_port" {
  type = number
}

variable "multi_az" {
  type = bool
}

variable "create_read_replica" {
  type = bool
}

variable "read_replica_count" {
  type = number
}

variable "allocated_storage" {
  type = number
}

variable "max_allocated_storage" {
  type = number
}

variable "storage_type" {
  type = string
}

variable "storage_encrypted" {
  type = bool
}

variable "backup_retention_period" {
  type = number
}

variable "backup_window" {
  type = string
}

variable "maintenance_window" {
  type = string
}

variable "publicly_accessible" {
  type = bool
}

variable "skip_final_snapshot" {
  type = bool
}

variable "deletion_protection" {
  type = bool
}

variable "replica_publicly_accessible" {
  type = bool
}

variable "replica_skip_final_snapshot" {
  type = bool
}

variable "db_password_length" {
  type = number
}

variable "db_password_special" {
  type = bool
}
