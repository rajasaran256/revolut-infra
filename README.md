# Terraform code for infrastructure provisioning

## Prerequisites

### Create a project and configure billing

1) Go to the [Manage resources](https://console.cloud.google.com/cloud-resource-manager?) page in the Cloud Console.
2) Select the organization, in which the project should be created, from organization drop-down list at the top of the page.
3) Click Create Project.
4) [Configure billing](https://cloud.google.com/billing/docs/how-to/manage-billing-account) for the project.

### Install and configure the Google cloud SDK

Download the [SDK](https://cloud.google.com/sdk/docs/) and run the installation:
```
./google-cloud-sdk/install.sh
```

### Create Service account for Terraform and download the credentials file

1) Create a Service account at project level and grant role/owner
2) Create credentials file for the Service account
```bash
$ gcloud iam service-accounts keys create ~/key.json \
  --iam-account [SA-NAME]@[PROJECT-ID].iam.gserviceaccount.com
```
If successful, then below output
```bash
created key [e44da1202f82f8f4bdd9d92bc412d1d8a837fa83] of type [json] as
[/usr/home/username/key.json] for
[SA-NAME@PROJECT-ID.iam.gserviceaccount.com]
```

### Enable Below APIs

- [Enable Compute Engine API](https://console.cloud.google.com/apis/library/compute.googleapis.com/)
- [Enable Kubernetes Engine API](https://console.cloud.google.com/apis/library/container.googleapis.com)
- [Enable Storage API](https://console.cloud.google.com/apis/library/storage-component.googleapis.com)

## Usage

### Download the repository

```bash
$ git clone git@github.com:rajasaran256/revolut-infra.git
```

### Add terraform.tfvars file

Assign values to all the input variables
Example
```bash
project             = "test-project"
network_name        = "demo-vpc"
subnet_name         = "demo-subnet"
credentials         = "/usr/home/username/key.json"
region              = "europe-west2"
subnet_ip           = "10.0.1.0/24"
gke_cluster_name    = "demo-cluster"
service_account_id  = "app-pipeline"
gcs_bucket_name     = "gcs-app-config"
```

### Execution

Then perform the following commands on the root folder

terraform init to get the plugins

terraform plan to see the infrastructure plan

terraform apply to apply the infrastructure build

terraform destroy to destroy the built infrastructure

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project | ID of the GCP project | string | n/a | yes |
| network_name | Name of the VPC network | string | n/a | yes |
| subnet_name | Name of the subnet | string | n/a | yes |
| credentials | Credentials file (JSON key) location| string | n/a | yes |
| region | Region in which the services will be created | string | n/a | yes |
| subnet_ip | IP range for the subnet | string | n/a | yes |
| gke_cluster_name | Name of the GKE cluster | string | n/a | yes |
| service_account_id | Service account for Application pipeline | string | n/a | yes |
| gcs_bucket_name | Name of GCS bucket where the configuration for application pipeline will be stored | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| app_pipeline_service_account | Service account for application pipeline |
| gcr_location | GCR registry URL |
| gcs_bucket | GCS bucket to store infrastructure configuration |
