variable "network" {

}

variable "world_reachable" {
  description = <<-EOT
  Specifies which ports are open to network traffic from anywhere.
  EOT
  type        = map(string)
}

variable "self_reachable" {
  description = <<-EOT
  Determines which ports and through which protocols are accessible
  from your local machine (from your public IP).
  EOT
  type = object({
    local_ip          = string
    protocol_to_ports = map(string)
  })
}

variable "runner_reachable" {
  description = <<-EOT
  Determines which ports and through which protocols can be reached
  from a self-hosted runner which runs on a machine with the IP
  specified in the object below.
  EOT
  type = object({
    runner_ip         = string
    protocol_to_ports = map(string)
  })
}

variable "range_reachable" {
  description = <<-EOT
  Allows defining scopes (ranges) from which specific ports on deployed machines
  will be accessible via given protocols.
  EOT
  type = object({
    remote_ips        = list(string)
    protocol_to_ports = map(string)
  })
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
