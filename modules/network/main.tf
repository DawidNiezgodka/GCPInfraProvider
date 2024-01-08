data "external" "self_ip" {
  program = ["/bin/bash", "${path.module}/get_ip.sh"]
}

resource "google_compute_firewall" "world-reachable" {
  name    = var.world_reachable_name
  network = var.network
  count   = var.world_reachable != null ? 1 : 0

  dynamic "allow" {
    for_each = var.world_reachable

    content {
      protocol = allow.key
      ports    = allow.key == "icmp" ? null : split(",", allow.value)
    }
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "self-reachable" {
  name    = var.self_reachable_name
  network = var.network
  count   = var.self_reachable.local_ip != "" ? 1 : 0

  dynamic "allow" {
    for_each = var.self_reachable.protocol_to_ports

    content {
      protocol = allow.key
      ports    = allow.key == "icmp" ? null : split(",", allow.value)
    }
  }
  source_ranges = [format("%s/%s", var.self_reachable.local_ip, 32)]
}

resource "google_compute_firewall" "range-reachable" {
  name    = var.range_reachable_name
  network = var.network
  count   = length(var.range_reachable.remote_ips) > 0 ? 1 : 0

  dynamic "allow" {
    for_each = var.range_reachable.protocol_to_ports

    content {
      protocol = allow.key
      ports    = allow.key == "icmp" ? null : split(",", allow.value)
    }
  }
  source_ranges = var.range_reachable.remote_ips
}

resource "google_compute_firewall" "runner-reachable" {
  name    = var.runner_reachable_name
  network = var.network
  count   = var.runner_reachable.runner_ip != "" ? 1 : 0

  dynamic "allow" {
    for_each = var.runner_reachable.protocol_to_ports

    content {
      protocol = allow.key
      ports    = allow.key == "icmp" ? null : split(",", allow.value)
    }
  }
  source_ranges = [format("%s/%s", var.runner_reachable.runner_ip, 32)]
}


