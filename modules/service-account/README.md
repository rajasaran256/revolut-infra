# Terraform Service account Module

This module creates and manages GKE cluster and Nodepools.

## Usage

Basic usage of this module is as follows:

```hcl
module service_account {
  source  = "./modules/service-account"
  project = "test-project"
  id      = "demo"
  role    = "roles/editor"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project | The ID of the project where service account will be created | string | n/a | yes |
| id | The unique id of the service account | string | n/a | yes |
| role | The role that should be applied | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| service_accounts | Name of the service account |
| roles | Roles that are applied to the service account |
