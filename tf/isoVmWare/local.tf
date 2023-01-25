locals {
  iso_dir             = "LinuxIso"
  ubuntu_releases_dir = "22.04.1"
  ubuntu_releases     = "https://releases.ubuntu.com/"
  ubuntu_image        = "ubuntu-22.04.1-live-server-amd64.iso"
  cd_rom_path_local   = "./${local.iso_dir}/${local.ubuntu_image}"
  cd_rom_path_remote  = "${local.iso_dir}/${local.ubuntu_image}"
}

data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter
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

data "vsphere_virtual_machine" "template" {
  name          = "ThanosTestVirtualMachineToBeDestroyed"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

#data "vsphere_virtual_machine" "template_ubuntu" {
#  name          = var.vsphere_virtual_machine_ubuntu_jammy
#  datacenter_id = data.vsphere_datacenter.datacenter.id
#}

#data "vsphere_virtual_machine" "template_windows" {
#  name          = var.vsphere_virtual_machine_windows_id
#  datacenter_id = data.vsphere_datacenter.datacenter.id
#}