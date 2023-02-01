locals {
  iso_dir                    = "DemoIsoImages"
  windows_image              = "Windows.iso"
  ubuntu_image               = "ubuntu-22.04.1-live-server-amd64.iso"
  cd_rom_path_remote_linux   = "${local.iso_dir}/${local.ubuntu_image}"
  cd_rom_path_remote_windows = "${local.iso_dir}/${local.windows_image}"
  vms_to_provision           = {
    linux_vm = {
      name                       = "ubuntu-iso"
      resource_pool_id           = data.vsphere_compute_cluster.cluster.resource_pool_id
      datastore_id               = data.vsphere_datastore.datastore.id
      num_cpus                   = var.num_cpus
      memory                     = var.memory
      guest_id                   = var.vsphere_virtual_machine_ubuntu
      wait_for_guest_net_timeout = var.wait_for_guest_net_timeout
      sync_time_with_host        = var.sync_time_with_host
      network_interfaces         = local.network_interfaces
      cdrom_content              = {
        datastore_id = data.vsphere_datastore.iso_datastore.id
        path         = local.cd_rom_path_remote_linux
      }
      disk_label = var.disk_label
      disk_size  = var.disk_size
    }
    windows_vm = {
      name                       = "windows-iso"
      resource_pool_id           = data.vsphere_compute_cluster.cluster.resource_pool_id
      datastore_id               = data.vsphere_datastore.datastore.id
      num_cpus                   = var.num_cpus
      memory                     = var.memory
      guest_id                   = var.vsphere_virtual_machine_windows
      wait_for_guest_net_timeout = var.wait_for_guest_net_timeout
      sync_time_with_host        = var.sync_time_with_host
      network_interfaces         = local.network_interfaces
      cdrom_content              = {
        datastore_id = data.vsphere_datastore.iso_datastore.id
        path         = local.cd_rom_path_remote_windows
      }
      disk_label = var.disk_label
      disk_size  = var.disk_size
    }
  }
  network_interfaces = [
    {
      network_id = data.vsphere_network.network.id
    }
  ]
}

data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "iso_datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_compute_cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network_vm
  datacenter_id = data.vsphere_datacenter.datacenter.id
}