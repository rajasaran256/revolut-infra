# ------------------------------------------------------------------------------
# CREATING A SUBNET
# ------------------------------------------------------------------------------
resource "google_compute_subnetwork" "subnetwork" {
  name                     = var.name
  ip_cidr_range            = var.subnet_ip
  region                   = var.region
  private_ip_google_access = var.privare_access
  network                  = var.network
  project                  = var.project
  description              = var.description
}
