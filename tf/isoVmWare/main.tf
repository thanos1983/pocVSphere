#module "vm-iso-linux" {
#  source                     = ".././modules/vsphereVirtualMachine"
#  name                       = local.vms_to_provision.linux_vm.name
#  resource_pool_id           = local.vms_to_provision.linux_vm.resource_pool_id
#  datastore_id               = local.vms_to_provision.linux_vm.datastore_id
#  num_cpus                   = local.vms_to_provision.linux_vm.num_cpus
#  memory                     = local.vms_to_provision.linux_vm.memory
#  guest_id                   = local.vms_to_provision.linux_vm.guest_id
#  wait_for_guest_net_timeout = local.vms_to_provision.linux_vm.wait_for_guest_net_timeout
#  sync_time_with_host        = local.vms_to_provision.linux_vm.sync_time_with_host
#  network_interfaces         = local.vms_to_provision.linux_vm.network_interfaces
#  cdrom_block                = local.vms_to_provision.linux_vm.cdrom_block
#  disk_block                 = local.disk_block_linux
#}

#module "vm-iso-windows" {
#  source                     = ".././modules/vsphereVirtualMachine"
#  name                       = local.vms_to_provision.windows_vm.name
#  resource_pool_id           = local.vms_to_provision.windows_vm.resource_pool_id
#  datastore_id               = local.vms_to_provision.windows_vm.datastore_id
#  num_cpus                   = local.vms_to_provision.windows_vm.num_cpus
#  memory                     = local.vms_to_provision.windows_vm.memory
#  guest_id                   = local.vms_to_provision.windows_vm.guest_id
#  wait_for_guest_net_timeout = local.vms_to_provision.windows_vm.wait_for_guest_net_timeout
#  sync_time_with_host        = local.vms_to_provision.windows_vm.sync_time_with_host
#  network_interfaces         = local.vms_to_provision.windows_vm.network_interfaces
#  cdrom_block                = local.vms_to_provision.windows_vm.cdrom_block
#  disk_block                 = local.disk_block_linux
#}

module "vm-iso" {
  source                     = ".././modules/vsphereVirtualMachine"
  for_each                   = local.vms_to_provision
  name                       = each.value.name
  resource_pool_id           = each.value.resource_pool_id
  datastore_id               = each.value.datastore_id
  num_cpus                   = each.value.num_cpus
  memory                     = each.value.memory
  guest_id                   = each.value.guest_id
  wait_for_guest_net_timeout = each.value.wait_for_guest_net_timeout
  sync_time_with_host        = each.value.sync_time_with_host
  network_interface_block    = each.value.network_interface_block
  cdrom_block                = each.value.cdrom_block
  disk_block                 = each.value.disk_block
}