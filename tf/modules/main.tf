resource "vsphere_virtual_machine" "vm" {
  alternate_guest_name       = var.alternate_guest_name
  wait_for_guest_net_timeout = var.wait_for_guest_net_timeout
  sync_time_with_host        = var.sync_time_with_host
  resource_pool_id           = var.resource_pool_id
  datastore_id               = var.datastore_id
  guest_id                   = var.guest_id
  num_cpus                   = var.num_cpus
  memory                     = var.memory
  name                       = var.name

  network_interface {
    network_id = var.network_interface_network_id
  }

  cdrom {
    datastore_id = var.cdrom_datastore_id
    path         = var.cdrom_path
  }

  disk {
    label = var.disk_label
    size  = var.disk_size
  }
}