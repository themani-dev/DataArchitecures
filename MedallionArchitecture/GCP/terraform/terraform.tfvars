project_id       = "hakoona-matata-298704"
service_account_name = "medallion-arch-sa"
vpc_name   = "medallion-vpc"
subnet_name = "medallion-subnet"
subnet_ip_range = "10.0.0.0/24"

bucket_configs = [
  {
    name               = "medallion-error"
    location           = "US-CENTRAL1"
    storage_class      = "NEARLINE"
    lifecycle_age_days = 60
  },
  {
    name               = "medallion-inbound"
    location           = "US-CENTRAL1"
    storage_class      = "STANDARD"
    lifecycle_age_days = 30
  },
  {
    name               = "medallion-archive"
    location           = "US"
    storage_class      = "ARCHIVE"
    lifecycle_age_days = 180
  },
  {
    name               = "medallion-artifacts"
    location           = "US"
    storage_class      = "NEARLINE"
    lifecycle_age_days = 60
  }
]
