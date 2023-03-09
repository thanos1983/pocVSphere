#module "vm-template-linux" {
#  source                     = "./modules/vsphereVirtualMachine"
#  name                       = "ubuntu-server-template-demo"
#  resource_pool_id           = data.vsphere_compute_cluster.cluster.resource_pool_id
#  datastore_id               = data.vsphere_datastore.datastore.id
#  num_cpus                   = var.num_cpus
#  memory                     = var.memory_linux
#  guest_id                   = data.vsphere_virtual_machine.template_linux.guest_id
#  scsi_type                  = data.vsphere_virtual_machine.template_linux.scsi_type
#  wait_for_guest_net_timeout = var.wait_for_guest_net_timeout
#  sync_time_with_host        = var.sync_time_with_host
#  network_interface_block    = local.network_interface_block_linux
#  disk_block                 = local.disk_block_linux
#  clone_block                = local.clone_block_linux
#}

#module "vm-template-windows" {
#  source                     = "./modules/vsphereVirtualMachine"
#  name                       = "windows-server-template-demo"
#  resource_pool_id           = data.vsphere_compute_cluster.cluster.resource_pool_id
#  datastore_id               = data.vsphere_datastore.datastore.id
#  num_cpus                   = var.num_cpus
#  memory                     = var.memory_windows
#  guest_id                   = data.vsphere_virtual_machine.template_windows.guest_id
#  scsi_type                  = data.vsphere_virtual_machine.template_windows.scsi_type
#  wait_for_guest_net_timeout = var.wait_for_guest_net_timeout
#  sync_time_with_host        = var.sync_time_with_host
#  network_interface_block    = local.network_interface_block_windows
#  disk_block                 = local.disk_block_windows
#  clone_block                = local.clone_block_windows
#}

module "vm-template" {
  source                     = "./modules/vsphereVirtualMachine"
  for_each                   = local.vms_to_provision
  name                       = each.value.name
  resource_pool_id           = each.value.resource_pool_id
  datastore_id               = each.value.datastore_id
  num_cpus                   = each.value.num_cpus
  efi_secure_boot_enabled    = each.value.efi_secure_boot_enabled
  memory                     = each.value.memory
  guest_id                   = each.value.guest_id
  scsi_type                  = each.value.scsi_type
  wait_for_guest_net_timeout = each.value.wait_for_guest_net_timeout
  sync_time_with_host        = each.value.sync_time_with_host
  network_interface_block    = each.value.network_interface_block
  disk_block                 = each.value.disk_block
  clone_block                = each.value.clone_block
}