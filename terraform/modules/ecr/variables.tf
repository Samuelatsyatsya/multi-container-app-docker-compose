# variables.tf
variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "backend_repository_name" {
  description = "Backend ECR repository name"
  type        = string
}

variable "frontend_repository_name" {
  description = "Frontend ECR repository name"
  type        = string
}

variable "project_tag" {
  description = "Project tag value"
  type        = string
}

variable "lifecycle_tag_prefixes" {
  description = "Tag prefixes to retain"
  type        = list(string)
}

variable "lifecycle_tagged_keep_count" {
  description = "Number of tagged images to keep"
  type        = number
}

variable "lifecycle_untagged_expire_days" {
  description = "Days before untagged images expire"
  type        = number
}
