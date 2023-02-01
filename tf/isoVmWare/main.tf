#module "vm-iso-linux" {
#  source                     = ".././modules"
#  name                       = local.vms_to_provision.linux_vm.name
#  resource_pool_id           = local.vms_to_provision.linux_vm.resource_pool_id
#  datastore_id               = local.vms_to_provision.linux_vm.datastore_id
#  num_cpus                   = local.vms_to_provision.linux_vm.num_cpus
#  memory                     = local.vms_to_provision.linux_vm.memory
#  guest_id                   = local.vms_to_provision.linux_vm.guest_id
#  wait_for_guest_net_timeout = local.vms_to_provision.linux_vm.wait_for_guest_net_timeout
#  sync_time_with_host        = local.vms_to_provision.linux_vm.sync_time_with_host
#  network_interfaces         = local.vms_to_provision.linux_vm.network_interfaces
#  cdrom_content              = local.vms_to_provision.linux_vm.cdrom_content
#  disk_label                 = local.vms_to_provision.linux_vm.disk_label
#  disk_size                  = local.vms_to_provision.linux_vm.disk_size
#}
#
#module "vm-iso-windows" {
#  source                     = ".././modules"
#  name                       = local.vms_to_provision.windows_vm.name
#  resource_pool_id           = local.vms_to_provision.windows_vm.resource_pool_id
#  datastore_id               = local.vms_to_provision.windows_vm.datastore_id
#  num_cpus                   = local.vms_to_provision.windows_vm.num_cpus
#  memory                     = local.vms_to_provision.windows_vm.memory
#  guest_id                   = local.vms_to_provision.windows_vm.guest_id
#  wait_for_guest_net_timeout = local.vms_to_provision.windows_vm.wait_for_guest_net_timeout
#  sync_time_with_host        = local.vms_to_provision.windows_vm.sync_time_with_host
#  network_interfaces         = local.vms_to_provision.windows_vm.network_interfaces
#  cdrom_content              = local.vms_to_provision.windows_vm.cdrom_content
#  disk_label                 = local.vms_to_provision.windows_vm.disk_label
#  disk_size                  = local.vms_to_provision.windows_vm.disk_size
#}

module "vm-iso" {
  source                     = ".././modules"
  for_each = local.vms_to_provision
  name                       = each.value.name
  resource_pool_id           = each.value.resource_pool_id
  datastore_id               = each.value.datastore_id
  num_cpus                   = each.value.num_cpus
  memory                     = each.value.memory
  guest_id                   = each.value.guest_id
  wait_for_guest_net_timeout = each.value.wait_for_guest_net_timeout
  sync_time_with_host        = each.value.sync_time_with_host
  network_interfaces         = each.value.network_interfaces
  cdrom_content              = each.value.cdrom_content
  disk_label                 = each.value.disk_label
  disk_size                  = each.value.disk_size
}