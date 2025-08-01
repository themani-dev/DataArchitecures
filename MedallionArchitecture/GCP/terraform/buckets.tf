resource "google_storage_bucket" "buckets" {
  for_each      = { for cfg in var.bucket_configs : cfg.name => cfg }
  name          = each.value.name
  location      = each.value.location
  storage_class = each.value.storage_class

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = each.value.lifecycle_age_days
    }
  }
}
