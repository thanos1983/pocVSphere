module "vm-iso" {
  source                     = ".././modules"
  name                       = var.name
  resource_pool_id           = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id               = data.vsphere_datastore.datastore.id
  num_cpus                   = var.num_cpus
  memory                     = var.memory
  guest_id                   = var.vsphere_virtual_machine_ubuntu
  wait_for_guest_net_timeout = var.wait_for_guest_net_timeout
  sync_time_with_host        = var.sync_time_with_host
  network_interfaces         = local.network_interfaces
  cdrom_content              = local.cdrom_content
  disk_label                 = var.disk_label
  disk_size                  = var.disk_size
}