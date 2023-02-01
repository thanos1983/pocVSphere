locals {
  network_interfaces = [
    {
      network_id   = data.vsphere_network.network.id
      adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
    }
  ]
  clone_content = {
    template_uuid = data.vsphere_virtual_machine.template.id
    linux_options_content = {
      host_name = "foo-demo-host"
      domain    = "NNITCORP.com"
    }
    network_interfaces = {
      #      ipv4_address = "10.98.135.76"
      #      ipv4_netmask = 24
    }
    #    ipv4_gateway = "10.98.135.254"
  }
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
  name          = var.name-template
  datacenter_id = data.vsphere_datacenter.datacenter.id
}