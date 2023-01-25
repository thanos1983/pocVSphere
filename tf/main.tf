resource "vsphere_virtual_machine" "vm" {
  name                       = "foo"
  resource_pool_id           = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id               = data.vsphere_datastore.datastore.id
  guest_id                   = var.vsphere_virtual_machine_ubuntu
  wait_for_guest_net_timeout = var.wait_for_guest_net_timeout
  sync_time_with_host        = var.sync_time_with_host
  num_cpus                   = var.num_cpus
  memory                     = var.memory
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  cdrom {
    datastore_id = data.vsphere_datastore.datastore.id
    path         = local.cd_rom_path_remote
  }
  disk {
    label = var.disc_label
    size  = var.disc_size
  }
}
