
variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Region for default resources"
  type        = string
  default     = "us-central1"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "custom-vpc"
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "custom-subnet"
}

variable "subnet_ip_range" {
  description = "Subnet IP range"
  type        = string
  default     = "10.10.0.0/16"
}

variable "service_account_name" {
  description = "Service account name"
  type        = string
  default     = "gcs-bucket-access-sa"
}

variable "bucket_configs" {
  description = "List of GCS bucket configurations"
  type = list(object({
    name               = string
    location           = string
    storage_class      = string
    lifecycle_age_days = number
  }))
}



