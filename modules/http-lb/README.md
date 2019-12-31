# Terraform HTTP Load balancer Module

This module creates all the components required to do HTTP load balancing across different regions.

## Usage

Basic usage of this module is as follows:

```hcl
module lb {
source       = "./modules/http-lb"
project      = "test-project"
ip_name      = "http-load-balancer"
backend_name = "test-backend"
backend_list = google_container_cluster.primary.instance_group_urls
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ip_name | The name of the Load balancer IP | string | n/a | yes |
| project | The ID of the project where subnets will be created | string | n/a | yes |
| backend_name | The name of the backend for Load balancer | string | n/a | yes |
| backend_list | List of backends | list(string) | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ip | Load balancer IP |
