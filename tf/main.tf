module "vm-template" {
  source                     = "./modules"
  name                       = var.name
  resource_pool_id           = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id               = data.vsphere_datastore.datastore.id
  num_cpus                   = var.num_cpus
  memory                     = var.memory
  guest_id                   = data.vsphere_virtual_machine.template.guest_id
  scsi_type                  = data.vsphere_virtual_machine.template.scsi_type
  wait_for_guest_net_timeout = var.wait_for_guest_net_timeout
  sync_time_with_host        = var.sync_time_with_host
  network_interfaces         = local.network_interfaces
  disk_label                 = var.disk_label
  disk_size                  = data.vsphere_virtual_machine.template.disks["0"].size
  thin_provisioned           = data.vsphere_virtual_machine.template.disks["0"].thin_provisioned
  clone_content              = local.clone_content
}