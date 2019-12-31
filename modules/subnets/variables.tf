
variable "project" {
  description = "The ID of the project where subnets will be created"
}

variable "network" {
  description = "The name of the network where subnets will be created"
}

variable "name" {
  description = "The name of the subnet being created"
}

variable "subnet_ip" {
  description = "The range of internal addresses for the subnet"
}

variable "region" {
  description = "The region of the subnet"
}

variable "privare_access" {
  description = "When enabled, VMs in this subnetwork without external IP addresses can access Google APIs and services by using Private Google Access"
  default     = "true"
}

variable "description" {
  description = "An optional description of this subnet"
  default     = ""
}
