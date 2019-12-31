# ------------------------------------------------------------------------------
# GOOGLE PROVIDER
# ------------------------------------------------------------------------------
provider "google" {
  credentials = var.credentials
  project     = var.project
  region      = var.region
}

# ------------------------------------------------------------------------------
# VPC CREATION
# ------------------------------------------------------------------------------
module "vpc" {
  source                  = "./modules/vpc"
  network_name            = var.network_name
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
  project_id              = var.project
  description             = "terraform VPC"
}

# ------------------------------------------------------------------------------
# SUBNET CREATION
# ------------------------------------------------------------------------------
module "subnets" {
  source      = "./modules/subnets"
  name        = var.subnet_name
  subnet_ip   = var.subnet_ip
  region      = var.region
  network     = module.vpc.network_name
  project     = var.project
  description = "First subnet eu-west-1"
}

# ------------------------------------------------------------------------------
# FIREWALL RULE CREATION
# ------------------------------------------------------------------------------
module firewall {
  source        = "./modules/firewall"
  name          = "ssh-rule"
  description   = "ssh connection to VPC"
  network       = module.vpc.network_name
  protocol      = "tcp"
  ports         = ["22"]
  source_ranges = ["0.0.0.0/0"]
}

data "google_container_registry_repository" "gcr" {
  project = var.project
  region  = var.region
}

# ------------------------------------------------------------------------------
# GKE CLUSTER CREATION
# ------------------------------------------------------------------------------
module gke {
  source       = "./modules/gke"
  project      = var.project
  name         = var.gke_cluster_name
  network      = module.vpc.network_name
  subnetwork   = module.subnets.name
  location     = var.region
  node_pool    = "node-pool-1"
  machine_type = "n1-standard-1"
  disk_size_gb = "100"
  disk_type    = "pd-standard"
  min_node     = "1"
  max_node     = "3"
}

# ------------------------------------------------------------------------------
# APPLICATION PIPELINE SERVICE ACCOUNT CREATION
# ------------------------------------------------------------------------------
module service_account {
  source  = "./modules/service-account"
  project = var.project
  id      = var.service_account_id
  role    = "roles/editor"
}

# ------------------------------------------------------------------------------
# GCS BUCKET CREATION
# ------------------------------------------------------------------------------
module gcs {
  source  = "./modules/gcs"
  project = var.project
  name      = var.gcs_bucket_name
  storage_class    = "STANDARD"
}

# ------------------------------------------------------------------------------
# CONFIGURATION FILE CREATION
# ------------------------------------------------------------------------------
resource "local_file" "file" {
    content     = "Project name = ${var.project}\ndefault region = ${var.region}\nVPC name = ${module.vpc.network_name}\nSubnet name = ${module.subnets.name}\nsubnet IP = ${var.subnet_ip}\nGCR URL = ${data.google_container_registry_repository.gcr.repository_url}\nGKE Cluster Name = ${var.gke_cluster_name}\nGKE Location = ${var.region}\nGKE VPC = ${module.vpc.network_name}\nGKE subnet = ${module.subnets.name}\nApp_pipeline_service_account = ${module.service_account.service_accounts}\nGCS bucket = ${module.gcs.gcs}"
    filename = "master.conf"
}

# ------------------------------------------------------------------------------
# UPLOADING CONFIGURATION FILE TO GCS BUCKET
# ------------------------------------------------------------------------------
resource "google_storage_bucket_object" "config" {
  name   = "master.config"
  source = local_file.file.filename
  bucket = module.gcs.gcs
}
