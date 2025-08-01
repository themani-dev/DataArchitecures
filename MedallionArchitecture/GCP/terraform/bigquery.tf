resource "google_bigquery_dataset" "bronze" {
  dataset_id = "bronze_layer"
  location   = var.region
}

resource "google_bigquery_dataset" "silver" {
  dataset_id = "silver_layer"
  location   = var.region
}

resource "google_bigquery_dataset" "gold" {
  dataset_id = "gold_layer"
  location   = var.region
}