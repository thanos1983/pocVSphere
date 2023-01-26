module "vm" {
  source                       = "./modules"
  name                         = "foo"
  resource_pool_id             = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id                 = data.vsphere_datastore.datastore.id
  guest_id                     = var.vsphere_virtual_machine_ubuntu
  wait_for_guest_net_timeout   = var.wait_for_guest_net_timeout
  sync_time_with_host          = var.sync_time_with_host
  num_cpus                     = var.num_cpus
  memory                       = var.memory
  network_interface_network_id = data.vsphere_network.network.id
  cdrom_datastore_id           = data.vsphere_datastore.datastore.id
  cdrom_path                   = local.cd_rom_path_remote
  disk_label                   = var.disk_label
  disk_size                    = var.disk_size
}
