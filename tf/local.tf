locals {
  network_interface_block_linux = {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template_linux.network_interface_types[0]
  }

  network_interface_block_windows = {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template_windows.network_interface_types[0]
  }

  clone_block_linux = {
    template_uuid   = data.vsphere_virtual_machine.template_linux.id
    customize_block = {
      linux_options_block = {
        host_name = "linux-demo-host"
        domain    = "MYDOMAIN.com"
      }
      network_interface_block = {
        #      ipv4_address = "10.98.135.76"
        #      ipv4_netmask = 24
      }
      #    ipv4_gateway = "10.98.135.254"
    }
  }

  clone_block_windows = {
    template_uuid   = data.vsphere_virtual_machine.template_windows.id
    customize_block = {
      windows_options_block = {
        computer_name  = "windows-demo-host"
        workgroup      = "MYWORKGROUP"
        admin_password = "VMware1!"
      }
      network_interface_block = {
        #      ipv4_address = "10.98.135.76"
        #      ipv4_netmask = 24
      }
      #    ipv4_gateway = "10.98.135.254"
    }
  }

  disk_block_linux = {
    label            = var.disk_label
    size             = data.vsphere_virtual_machine.template_linux.disks["0"].size
    thin_provisioned = data.vsphere_virtual_machine.template_linux.disks["0"].thin_provisioned
  }

  disk_block_windows = {
    label            = var.disk_label
    size             = data.vsphere_virtual_machine.template_windows.disks["0"].size
    thin_provisioned = data.vsphere_virtual_machine.template_windows.disks["0"].thin_provisioned
  }

  vms_to_provision = {
    linux_vm = {
      name                       = "ubuntu-server-template-demo"
      resource_pool_id           = data.vsphere_compute_cluster.cluster.resource_pool_id
      datastore_id               = data.vsphere_datastore.datastore.id
      num_cpus                   = var.num_cpus
      efi_secure_boot_enabled    = var.efi_secure_boot_enabled_linux
      memory                     = var.memory_linux
      guest_id                   = data.vsphere_virtual_machine.template_linux.guest_id
      scsi_type                  = data.vsphere_virtual_machine.template_linux.scsi_type
      wait_for_guest_net_timeout = var.wait_for_guest_net_timeout
      sync_time_with_host        = var.sync_time_with_host
      network_interface_block    = local.network_interface_block_linux
      disk_block                 = local.disk_block_linux
      clone_block                = local.clone_block_linux
    }
    windows_vm = {
      name                       = "windows-server-template-demo"
      resource_pool_id           = data.vsphere_compute_cluster.cluster.resource_pool_id
      datastore_id               = data.vsphere_datastore.datastore.id
      num_cpus                   = var.num_cpus
      efi_secure_boot_enabled    = var.efi_secure_boot_enabled_windows
      memory                     = var.memory_windows
      guest_id                   = data.vsphere_virtual_machine.template_windows.guest_id
      scsi_type                  = data.vsphere_virtual_machine.template_windows.scsi_type
      wait_for_guest_net_timeout = var.wait_for_guest_net_timeout
      sync_time_with_host        = var.sync_time_with_host
      network_interface_block    = local.network_interface_block_windows
      disk_block                 = local.disk_block_windows
      clone_block                = local.clone_block_windows
    }
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

data "vsphere_virtual_machine" "template_linux" {
  name          = var.name-template-linux
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template_windows" {
  name          = var.name-template-windows
  datacenter_id = data.vsphere_datacenter.datacenter.id
}