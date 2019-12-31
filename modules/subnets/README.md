# Terraform Subnet Module

This module creates the individual vpc subnet.

## Usage

Basic usage of this submodule is as follows:

```hcl
module "subnets" {
  source      = "./modules/subnets"
  name        = "test-subnet"
  subnet_ip   = "10.0.1.0/24"
  region      = "europe-west1"
  network     = module.vpc.network_name
  project     = "test-vpc"
  description = "description of test-subnet"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | The name of the network where subnet will be created | string | n/a | yes |
| project | The ID of the project where subnet will be created | string | n/a | yes |
| subnet_ip | IP ranges that will be used for the subnet | string | n/a | yes |
| description | description of the subnet | string | subnet | no |
| region | The location in which the subnet will be created | string | n/a | yes |
| network | VPC in which the subnet is created | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| subnets | The created subnet resources |
