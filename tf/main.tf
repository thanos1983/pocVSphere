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
  network_interface_block    = local.network_interface_block
  disk_label                 = var.disk_label
  disk_size                  = data.vsphere_virtual_machine.template.disks["0"].size
  thin_provisioned           = data.vsphere_virtual_machine.template.disks["0"].thin_provisioned
  clone_block                = local.clone_block
}

#resource "vsphere_virtual_machine" "vm" {
#  name             = "foo"
#  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
#  datastore_id     = data.vsphere_datastore.datastore.id
#  num_cpus         = 1
#  memory           = 1024
#  guest_id         = data.vsphere_virtual_machine.template.guest_id
#  network_interface {
#    network_id = data.vsphere_network.network.id
#  }
#  disk {
#    label            = "disk0"
#    size             = 20
#    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
#  }
#  clone {
#    template_uuid = data.vsphere_virtual_machine.template.id
#    customize {
#      linux_options {
#        host_name = local.clone_block.customize_block.linux_options_block.host_name
#        domain    = local.clone_block.customize_block.linux_options_block.domain
#      }
#      network_interface {}
#    }
#  }
#}