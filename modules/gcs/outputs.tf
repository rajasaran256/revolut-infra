output "gcs" {
  value       = google_storage_bucket.image_store.name
  description = "Name of the GCS bucket"
}
