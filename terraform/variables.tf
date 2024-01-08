variable "service_account_email" {
  description = "Email of the service account for managing GCP resources"
  type        = string
  sensitive   = true
}

variable "project" {
  description = "The project ID to deploy to"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "The region to deploy to"
  type        = string
  default     = "europe-west3"
}

variable "network_name" {
  description = "The name of the network to deploy to"
  type        = string
  default     = "bench-net"
}

variable "router_name" {
  description = "The name of the router to deploy to"
  type        = string
  default     = "router"
}


variable "zone" {
  description = "The zone to deploy to. For now, only a single zone deployment is supported"
  type        = string
  default     = "europe-west3-a"
}

// **************
// GitHub variables
// **************

variable "gcp_user" {
  description = "The name of the first GCP user"
  type        = string
  sensitive   = true
}

variable "local_ip" {
  description = "The known local IP address"
  type        = string
  sensitive   = true
  default     = ""
}

variable "runner_ip" {
  description = "The known local IP address"
  type        = string
  sensitive   = true
  default     = ""
}

variable "gha_workspace" {
  description = "The GitHub Actions workspace directory"
  type        = string
  default     = ""
}

// **************
// Network module variables
// **************

variable "self_reachable_protocol_port_map" {
  type        = map(string)
  default     = {}
  description = "The port map for the self-reachable firewall rule"
}

variable "world_reachable_protocol_port_map" {
  type        = map(string)
  description = "The port map for the self-reachable firewall rule"
  default     = null
}

variable "range_reachable_protocol_port_map" {
  type        = map(string)
  default     = {}
  description = "The port map for the self-reachable firewall rule"
}

variable "remote_ips" {
  type        = list(string)
  default     = []
  description = "The list of remote IPs to allow"
}

variable "runner_reachable_protocol_port_map" {
  type        = map(string)
  default     = {}
  description = "The port map for the self-reachable firewall rule"
}

variable "self_reachable_name" {
  type        = string
  default     = "self-reachable"
  description = "The name for the firewall rule for self-reachability"
}

variable "world_reachable_name" {
  type        = string
  default     = "world-reachable"
  description = "The name for the firewall rule for world-reachability"
}

variable "range_reachable_name" {
  type        = string
  default     = "range-reachable"
  description = "The name for the firewall rule for range-reachability"
}

variable "runner_reachable_name" {
  type        = string
  default     = "runner-reachable"
  description = "The name for the firewall rule for runner-reachability"
}

// Disk
variable "disk_size" {
  description = "The size of the disk in GB"
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "The type of the disk"
  type        = string
  default     = "pd-ssd"
}
