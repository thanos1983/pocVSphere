#variable "clones" {
#  description = "The clones block can be used to create a new virtual machine from an existing virtual machine or template."
#  type        = optional(list(object({
#    template_uuid  = optional(string)
#    linked_clone   = optional(string)
#    timeout        = optional(number)
#    customizations = optional(list(object({
#      timeout            = optional(number)
#      network_interfaces = optional(list(object({
#        dns_server_list = optional(string)
#        dns_domain      = optional(string)
#        ipv4_address    = optional(string)
#        ipv4_netmask    = optional(number)
#        ipv6_address    = optional(string)
#        ipv6_netmask    = optional(number)
#      })))
#      ipv4_gateway    = optional(string)
#      ipv6_gateway    = optional(string)
#      dns_server_list = optional(string)
#      dns_suffix_list = optional(string)
#      linux_options   = optional(object({
#        host_name    = optional(string)
#        domain       = optional(string)
#        hw_clock_utc = optional(string)
#        script_text  = optional(string)
#        time_zone    = optional(string)
#      }))
#      windows_options = optional(object({
#        computer_name         = optional(string)
#        admin_password        = optional(string)
#        workgroup             = optional(string)
#        join_domain           = optional(string)
#        domain_admin_user     = optional(string)
#        domain_admin_password = optional(string)
#        full_name             = optional(string)
#        organization_name     = optional(string)
#        product_key           = optional(string)
#        run_once_command_list = optional(list(string))
#        auto_logon            = optional(bool)
#        auto_logon_count      = optional(number)
#        time_zone             = optional(number)
#        windows_sysprep_text  = optional(string)
#      }))
#    })))
#  })))
#  default = []
#}

locals {
  iso_dir             = "DemoIsoImages"
  ubuntu_releases_dir = "22.04.1"
  ubuntu_releases     = "https://releases.ubuntu.com/"
  ubuntu_image        = "ubuntu-22.04.1-live-server-amd64.iso"
  cd_rom_path_local   = "${local.iso_dir}/${local.ubuntu_image}"
  cd_rom_path_remote  = "${local.iso_dir}/${local.ubuntu_image}"
  network_interfaces  = [
    {
      network_id = data.vsphere_network.network.id
    }
  ]
  cdrom_content = {
    datastore_id = data.vsphere_datastore.iso_datastore.id
    path         = local.cd_rom_path_local
  }
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