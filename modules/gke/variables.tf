
variable "project" {
  description = "The ID of the project where subnets will be created"
}

variable "network" {
  description = "The name of the network where GKE cluster will be created"
}

variable "name" {
  description = "The name of the GKE cluster being created"
}

variable "subnetwork" {
  description = "The name of the subnet where GKE cluster will be created"
}

variable "location" {
  description = "The region of the GKE cluster"
}

variable "node_pool" {
  description = "The name of the node pool"
}

variable "min_node" {
  description = "Minimum number of nodes in the node pool"
}

variable "max_node" {
  description = "Maximum number of nodes in the node pool"
}

variable "machine_type" {
  description = "The machine type for the node pool"
  default     = "n1-standard-1"
}

variable "disk_size_gb" {
  description = "Hard disk size for the node pool"
}

variable "disk_type" {
  description = "Hard disk size for the node pool"
  default     = "pd-standard"
}
