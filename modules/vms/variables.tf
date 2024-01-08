variable "service_account_email" {
  description = "The service account email to use for the instances"
  type        = string
}

variable "zone" {
  description = "The zone to deploy to"
  type        = string
}

variable "network_name" {
  description = "The network to deploy to"
  type        = string
}

variable "subnetwork_name" {
  description = "The subnetwork to deploy to"
  type        = string
}

variable "tags" {
  description = "The tags to apply to the instances"
  type        = list(string)
  default = []
}

variable "configuration" {
  description = "The configuration to apply to the instances"
  type = list(object({
    name         = string
    count        = number
    labels       = map(list(string))
    machine_type = string
    image        = string
  }))
}

variable "gcp_user" {
  description = "The name of the first GCP user"
  type        = string
  sensitive   = true
}

variable "machine_count" {
  description = "Number of machines to create"
  type        = number
}

variable "name_prefix" {
  description = "The name to be used for machines"
  type        = string
}

variable "labels" {
  description = "The labels to be used for machines"
  type        = map(list(string))
}

variable "machine_type" {
  description = ""
  type        = string
}

variable "image" {
  description = ""
  type        = string
}

variable "disk" {
  type = object({
    name = string
    size = number
    type = string
  })
}
