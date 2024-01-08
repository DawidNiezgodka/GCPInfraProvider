%{ for cfg in configuration ~}
%{ for role in cfg.labels.role ~}
[${role}]
%{ for vm in vm_info ~}
%{ if substr(vm.name, 0, length(cfg.name)) == cfg.name ~}
${vm.name} ansible_host=${vm.ext_ip}
%{ endif ~}
%{ endfor ~}
%{ endfor ~}
%{ endfor ~}
