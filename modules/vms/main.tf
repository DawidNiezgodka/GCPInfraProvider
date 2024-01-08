resource "google_compute_address" "external_ip" {
  count = var.machine_count
  name  = "${var.name_prefix}-${count.index}-external-ip-${count.index}"
}

resource "google_compute_instance" "vms" {
  count        = var.machine_count
  name         = "${var.name_prefix}${count.index + 1}"
  machine_type = var.machine_type
  zone         = var.zone
  labels       = { for k, v in var.labels : k => join("-", v) }

  boot_disk {
    initialize_params {
      image = var.image
      type  = var.disk != null ? var.disk.type : "pd-standard"
      size  = var.disk != null ? var.disk.size : 10
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork_name
    access_config {
      nat_ip = google_compute_address.external_ip[count.index].address
    }
  }

  service_account {
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }

  tags = var.tags

  metadata = {
    ssh-keys = join("\n", [
      "${var.gcp_user}:${trimspace(file("${path.root}/publickeys/public_key.pub"))}"
    ])
  }

  lifecycle {
    create_before_destroy = true
  }
}
