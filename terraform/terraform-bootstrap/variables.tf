variable "backend_bucket_name" {
  type        = string
  description = "S3 bucket name used for Terraform backend state"
}

variable "project_tag" {
  type        = string
  description = "Project tag value"
}
