locals {
  allow_internal_cidr = ["10.128.0.0/9"]
}

resource "google_compute_network" "ansible_network" {
  project                 = var.project
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "ansible_subnetwork" {
  name          = "subnet-ansible"
  ip_cidr_range = "10.128.100.0/24"
  region        = var.region
  network       = google_compute_network.ansible_network.self_link
}

resource "google_compute_router" "default_router" {
  name    = var.router_name
  project = var.project
  network = google_compute_network.ansible_network.self_link
  region  = var.region
}

// Provides internet connectivity for resources within private network.
module "cloud-nat" {
  source     = "terraform-google-modules/cloud-nat/google"
  version    = "3.0.0"
  project_id = var.project
  region     = var.region
  router     = google_compute_router.default_router.name
  name       = "simple-nat"
}

resource "google_compute_firewall" "allow-internal" {
  name    = "allow-internal"
  project = var.project
  network = google_compute_network.ansible_network.self_link
  allow {
    protocol = "tcp"
    ports    = ["1-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["1-65535"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = local.allow_internal_cidr
}

resource "google_compute_firewall" "allow_ssh_ingress_from_iap" {
  name      = "allow-ssh-ingress-from-iap"
  network   = google_compute_network.ansible_network.self_link
  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
}

//////////////////////////////////////////////////////
// User desired firewall rules (created via module) //
//////////////////////////////////////////////////////

module "benchmark_firewall_rules" {
  source          = "../modules/network"
  network         = google_compute_network.ansible_network.self_link
  world_reachable = var.world_reachable_protocol_port_map
  self_reachable = {
    local_ip          = var.local_ip
    protocol_to_ports = var.self_reachable_protocol_port_map
  }
  runner_reachable = {
    runner_ip         = var.runner_ip
    protocol_to_ports = var.runner_reachable_protocol_port_map
  }
  range_reachable = {
    remote_ips        = var.remote_ips
    protocol_to_ports = var.range_reachable_protocol_port_map
  }
}
