#resource "null_resource" "iso" {
#  triggers = {
#    on_version_change = local.ubuntu_image
#  }
#
#  provisioner "local-exec" {
#    command = "curl -o ${local.iso_dir}/${local.ubuntu_image} ${local.ubuntu_releases}/${local.ubuntu_releases_dir}/${local.ubuntu_image}"
#  }
#
#  #  provisioner "local-exec" {
#  #    when    = destroy
#  #    command = "rm -f ${local.iso_dir}/${local.ubuntu_image}"
#  #  }
#}

#resource "vsphere_file" "ubuntu_iso_upload" {
#  datastore          = var.vsphere_datastore
#  datacenter         = var.vsphere_datacenter
#  source_file        = local.cd_rom_path_local
#  destination_file   = local.cd_rom_path_remote
#  create_directories = true
#}

resource "vsphere_virtual_machine" "vm" {
  name                = "foo"
  resource_pool_id    = data.vsphere_compute_cluster.cluster.resource_pool_id
  scsi_type           = data.vsphere_virtual_machine.template.scsi_type
  guest_id            = data.vsphere_virtual_machine.template.guest_id
  datastore_id        = data.vsphere_datastore.datastore.id
  num_cpus            = var.num_cpus
  memory              = var.memory
  sync_time_with_host = true
  # wait_for_guest_net_timeout = -1
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  #  cdrom {
  #    datastore_id = data.vsphere_datastore.datastore.id
  #    path         = local.cd_rom_path_remote
  #  }
  disk {
    label = "disk0"
    size  = 20
  }
  # dependency on the vsphere_file that Terraform cannot
  # automatically infer, so it must be declared explicitly:
  #  depends_on = [
  #    vsphere_file.ubuntu_iso_upload
  #  ]
}
