output "created_bucket_names" {
  value = [for b in google_storage_bucket.buckets : b.name]
}

output "service_account_email" {
  value = google_service_account.medallion_arch_sa.email
}



output "bigquery_datasets" {
  description = "BigQuery datasets created"
  value = [
    google_bigquery_dataset.bronze.dataset_id,
    google_bigquery_dataset.silver.dataset_id,
    google_bigquery_dataset.gold.dataset_id
  ]
}

output "bigquery_datasets_full_names" {
  description = "Full BigQuery dataset resource names"
  value = [
    google_bigquery_dataset.bronze.self_link,
    google_bigquery_dataset.silver.self_link,
    google_bigquery_dataset.gold.self_link
  ]
}

output "Cloud_functions_created" {
  description = "Cloud functions created "
  value = [
    google_cloudfunctions_function.firestore_trigger_gen1.name,
    google_cloudfunctions_function.gcs_trigger_gen1.name,
    google_cloudfunctions2_function.trigger_gcs_gen2.name
  ]
}