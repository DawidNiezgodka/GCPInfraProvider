output "complete_info" {
  value = flatten([for v in module.deployment : v.instance_info])
}

output "external_ips" {
  value = flatten([for v in module.deployment : v.all_external_ips])
}

output "file_content" {
  value = templatefile("${path.module}/templates/hosts.tpl",
    {
      vm_info       = flatten([for v in module.deployment : v.instance_info])
      configuration = var.configuration
    }
  )
  description = "Content of the generated file"
}
