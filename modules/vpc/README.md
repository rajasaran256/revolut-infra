# Terraform VPC Network Module

This modulecreates a vpc network.


## Usage

Basic usage of this module is as follows:

```hcl
module "vpc" {
  source                  = "./modules/vpc"
  network_name            = "vpc-network"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
  project_id              = "test-project"
  description             = "terraform VPC"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| auto_create_subnetworks | When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources. | bool | `"false"` | no |
| description | An optional description of this resource. The resource must be recreated to modify this field. | string | `""` | no |
| network_name | The name of the network being created | string | n/a | yes |
| project_id | The ID of the project where this VPC will be created | string | n/a | yes |
| routing_mode | The network routing mode (default 'GLOBAL') | string | `"GLOBAL"` | no |

## Outputs

| Name | Description |
|------|-------------|
| network | The VPC resource being created |
| network_name | The name of the VPC being created |
| network_self_link | The URI of the VPC being created |
| project_id | VPC project id |
