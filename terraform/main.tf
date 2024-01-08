module "deployment" {
  source = "../modules/vms"

  for_each              = { for index, cfg in var.configuration : index => cfg }
  name_prefix           = each.value.name
  machine_count         = each.value.count
  labels                = each.value.labels
  configuration         = var.configuration
  zone                  = var.zone
  network_name          = google_compute_network.ansible_network.name
  subnetwork_name       = google_compute_subnetwork.ansible_subnetwork.name
  tags                  = each.value.tags
  service_account_email = var.service_account_email
  gcp_user              = var.gcp_user
  image                 = each.value.image
  machine_type          = each.value.machine_type
  disk                 = each.value.disk
}

resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/templates/hosts.tpl",
    {
      vm_info       = flatten([for v in module.deployment : v.instance_info])
      configuration = var.configuration
    }
  )
  filename = var.gha_workspace != "" ? "${var.gha_workspace}/hosts.cfg" : "hosts.cfg"
}


