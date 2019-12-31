# Terraform GKE Module

This module creates and manages GKE cluster and Nodepools.

## Usage

Basic usage of this module is as follows:

```hcl
module gke {
  source       = "./modules/gke"
  project      = "test-project"
  name         = "gke-cluster"
  network      = "test-vpc"
  subnetwork   = "test-subnet"
  location     = "europe-west1"
  node_pool    = "test-node-pool"
  machine_type = "n1-standard-1"
  disk_size_gb = "100"
  disk_type    = "pd-standard"
  min_node     = "1"
  max_node     = "3"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | The name of the GKE cluster will be created | string | n/a | yes |
| project | The ID of the project where subnets will be created | string | n/a | yes |
| network | VPC in which the GKE cluster is created | string | n/a | yes |
| subnets | Subnet in which the GKE cluster is created | string | n/a | yes |
| location | The location (region or zone) in which the cluster master will be created | string | n/a | yes |
| node_pool | Name of the node pool which will be used by the GKE cluster | string | n/a | yes |
| machine_type | The name of a Google Compute Engine machine type | string | n1-standard-1 | no |
| disk_type | Type of the disk attached to each node (e.g. 'pd-standard' or 'pd-ssd') | string | pd-standard | no |
| disk_size_gb |  Size of the disk attached to each node, specified in GB | string | n/a | yes |
| min_node | Minimum available node for the node pool | string | n/a | yes |
| max_node | Maximum available node for the node pool | string | n/a | yes |


## Outputs

| Name | Description |
|------|-------------|
| gke | The created GKE resources |
| instance_group_urls | Instance group of the GKE cluster |
