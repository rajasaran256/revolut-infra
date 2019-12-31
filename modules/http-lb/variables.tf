
variable "project" {
  description = "The ID of the project where subnets will be created"
}

variable "ip_name" {
  description = "The name of the Load balancer IP"
}

variable "backend_name" {
  description = "The name of the backend for Load balancer"
}

variable "backend_list" {
  description = "List of backends"
}
