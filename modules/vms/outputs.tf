output "instance_info" {
  value = [
    for idx, instance in google_compute_instance.vms.* :
    {
      index  = idx + 1
      name   = instance.name
      ext_ip = instance.network_interface[0].access_config[0].nat_ip
      int_ip = instance.network_interface[0].network_ip
    }
  ]
}

output "all_external_ips" {
  value = [
    for instance in google_compute_instance.vms.* :
    instance.network_interface[0].access_config[0].nat_ip
  ]
}
