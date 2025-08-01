
resource "google_storage_bucket_iam_member" "bucket_iam" {
  for_each = { for cfg in var.bucket_configs : cfg.name => cfg }

  bucket = google_storage_bucket.buckets[each.key].name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.medallion_arch_sa.email}"
}


resource "google_project_iam_member" "vpc_access" {
  project = var.project_id
  role    = "roles/vpcaccess.user"
  member  = "serviceAccount:${google_service_account.medallion_arch_sa.email}"
}

resource "google_project_iam_member" "firestore_read_access" {
  project = var.project_id
  role    = "roles/datastore.viewer"
  member  = "serviceAccount:${google_service_account.medallion_arch_sa.email}"
}
