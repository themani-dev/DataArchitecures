resource "google_storage_bucket_object" "cf_source" {
  name   = "initial.zip"
  bucket = google_storage_bucket.buckets["medallion-artifacts"].name
  source = "initialScripts/cloudfunctions/initial.zip"  # Replace with your zipped source
}

resource "google_cloudfunctions2_function" "trigger_gcs_gen2" {
  name        = "gcs-gen2-trigger"
  location    = var.region
  project     = var.project_id
  description = "Triggered on new object in inbound bucket"

  depends_on = [
    google_storage_bucket.buckets
  ]

  build_config {
    runtime     = "python311"
    entry_point = "entry"  # update to actual function name inside main.py
    source {
      storage_source {
        bucket = google_storage_bucket_object.cf_source.bucket
        object = google_storage_bucket_object.cf_source.name
      }
    }
  }

  service_config {
    max_instance_count    = 1
    available_memory      = "256M"
    timeout_seconds       = 60
    service_account_email = google_service_account.medallion_arch_sa.email
    #vpc_connector          = google_vpc_access_connector.connector.name
    environment_variables = {
      DATASET = "bronze"
    }
  }

  event_trigger {
    trigger_region = var.region
    event_type     = "google.cloud.storage.object.v1.finalized"
    event_filters {
      attribute = "bucket"
      value     = google_storage_bucket.buckets["medallion-inbound"].name
    }
    retry_policy = "RETRY_POLICY_RETRY"
  }
}



resource "google_cloudfunctions_function" "gcs_trigger_gen1" {
  name        = "trigger-gcs-gen1"
  runtime     = "python311"
  entry_point = "entry"
  region      = var.region
  source_archive_bucket = google_storage_bucket_object.cf_source.bucket
  source_archive_object = google_storage_bucket_object.cf_source.name
  available_memory_mb   = 256
  service_account_email = google_service_account.medallion_arch_sa.email

  depends_on = [
    google_storage_bucket.buckets
  ]

  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = google_storage_bucket.buckets["medallion-inbound"].name
  }

  environment_variables = {
    ENV = "dev"
  }
}

resource "google_cloudfunctions_function" "firestore_trigger_gen1" {
  name        = "trigger-firestore-function"
  runtime     = "python311"
  entry_point = "entry"
  region      = var.region
  source_archive_bucket = google_storage_bucket_object.cf_source.bucket
  source_archive_object = google_storage_bucket_object.cf_source.name
  available_memory_mb   = 256
  service_account_email = google_service_account.medallion_arch_sa.email


  event_trigger {
    event_type = "providers/cloud.firestore/eventTypes/document.update"
    resource   = "projects/${var.project_id}/databases/(default)/documents/events/{docId}"
  }
}
