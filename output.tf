output "gcr_location" {
  value = data.google_container_registry_repository.gcr.repository_url
  description = "GCR registry URL"
}

output "app_pipeline_service_account" {
  value = module.service_account.service_accounts
  description = "Service account for application pipeline"
}

output "gcs_bucket" {
  value = module.gcs.gcs
  description = "GCS bucket to store infrastructure configuration"
}
