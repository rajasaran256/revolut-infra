output "gke" {
  value       = google_container_cluster.primary
  description = "The created GKE resources"
}

output "instance_group_urls" {
  value       = google_container_cluster.primary.instance_group_urls
  description = "Instance group of the GKE cluster"
}
