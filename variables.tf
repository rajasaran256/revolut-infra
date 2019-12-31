variable "project" {
  description = "ID of the GCP project"
}

variable "network_name" {
  description = "Name of the VPC network"
}

variable "credentials" {
  description = "Credentials file (JSON key) location"
}

variable "region" {
  description = "Region in which the services will be created"
}

variable "subnet_name" {
  description = "Name of the subnet"
}

variable "subnet_ip" {
  description = "IP range for the subnet"
}

variable "gke_cluster_name" {
  description = "Name of the GKE cluster"
}

variable "service_account_id" {
  description = "Service account for Application pipeline"
}

variable "gcs_bucket_name" {
  description = "Name of GCS bucket where the configuration for application pipeline will be stored"
}
