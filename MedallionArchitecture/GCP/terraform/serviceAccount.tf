resource "google_service_account" "medallion_arch_sa" {
  account_id   = var.service_account_name
  display_name = "Service Account for Medallion architecture"
}
