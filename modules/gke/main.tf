# ------------------------------------------------------------------------------
# CREATING A GKE CLUSTER
# ------------------------------------------------------------------------------
resource "google_container_cluster" "primary" {
  name                     = var.name
  location                 = var.location
  initial_node_count       = 1
  remove_default_node_pool = true
  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
  network    = var.network
  subnetwork = var.subnetwork
  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

}

# ------------------------------------------------------------------------------
# CREATING A NODE POOL
# ------------------------------------------------------------------------------
resource "google_container_node_pool" "primary_node_pool" {
  name               = var.node_pool
  location           = var.location
  cluster            = google_container_cluster.primary.name
  initial_node_count = 1

  autoscaling {
    min_node_count = var.min_node
    max_node_count = var.max_node
  }


  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb
    disk_type    = var.disk_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/devstorage.read_only",
    ]
  }
  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}
