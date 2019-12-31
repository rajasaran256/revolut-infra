output "ip" {
  value       = google_compute_global_address.default.address
  description = "Load balancer IP"
}
