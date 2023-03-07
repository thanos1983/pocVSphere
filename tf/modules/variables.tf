variable "alternate_guest_name" {
  description = "The guest name for the operating system when guest_id is otherGuest or otherGuest64."
  type        = string
  default     = null
}

variable "annotation" {
  description = "A user-provided description of the virtual machine."
  type        = string
  default     = null
}

variable "cdrom_block" {
  description = "A specification for a CD-ROM device on the virtual machine."
  type        = object({
    datastore_id = string
    path         = string
  })
  default = null
}

variable "clone_block" {
  description = "The clone block can be used to create a new virtual machine from an existing virtual machine or template."
  type        = object({
    template_uuid   = string
    linked_clone    = optional(bool)
    timeout         = optional(number)
    customize_block = optional(object({
      timeout                 = optional(number)
      network_interface_block = object({
        dns_server_list = optional(set(string))
        dns_domain      = optional(string)
        ipv4_address    = optional(string)
        ipv4_netmask    = optional(number)
        ipv6_address    = optional(string)
        ipv6_netmask    = optional(number)
      })
      ipv4_gateway        = optional(string)
      ipv6_gateway        = optional(string)
      dns_server_list     = optional(set(string))
      dns_suffix_list     = optional(set(string))
      linux_options_block = optional(object({
        host_name    = string
        domain       = string
        hw_clock_utc = optional(bool)
        script_text  = optional(string)
        time_zone    = optional(string)
      }))
      windows_options_block = optional(object({
        computer_name         = string
        admin_password        = optional(string)
        workgroup             = optional(string)
        join_domain           = optional(string)
        domain_admin_user     = optional(string)
        domain_admin_password = optional(string)
        full_name             = optional(string)
        organization_name     = optional(string)
        product_key           = optional(string)
        run_once_command_list = optional(set(string))
        auto_logon            = optional(bool)
        auto_logon_count      = optional(number)
        time_zone             = optional(number)
      }))
      windows_sysprep_text = optional(string)
    }))
  })
  default = null
}

variable "extra_config_reboot_required" {
  description = "Allow the virtual machine to be rebooted when a change to extra_config occurs."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.extra_config_reboot_required))
    error_message = "Invalid input, valid input options are boolean: true or false."
  }
  default = true
}

variable "custom_attributes" {
  description = "Map of custom attribute ids to attribute value strings to set for virtual machine."
  type        = map(string)
  default     = null
}

variable "datastore_id" {
  description = "The datastore ID that on which the ISO is located. Required for using a datastore ISO."
  type        = string
  default     = null
}

variable "datastore_cluster_id" {
  description = "The managed object reference ID of the datastore cluster in which to place the virtual machine."
  type        = string
  default     = null
}

variable "datacenter_id" {
  description = "The datacenter ID."
  type        = string
  default     = null
}

variable "vsphere_datastore" {
  description = "The vsphere_datastore data source can be used to discover the ID of a vSphere datastore object."
  default     = "LocalSSD01"
  type        = string
}

variable "vsphere_compute_cluster" {
  description = "The vsphere_compute_cluster data source can be used to discover the ID of a cluster in vSphere."
  default     = "TestCluster"
  type        = string
}

variable "vsphere_network_vm" {
  description = "The vsphere_network data source can be used to discover the ID of a network in vSphere VM Network."
  default     = "VM Network"
  type        = string
}

variable "scsi_type" {
  description = "The SCSI controller type for the virtual machine."
  type        = string
  default     = "pvscsi"
}

variable "scsi_bus_sharing" {
  description = "The type of SCSI bus sharing for the virtual machine SCSI controller."
  type        = string
  validation {
    condition     = contains(["virtualSharing", "physicalSharing", "noSharing"], var.scsi_bus_sharing)
    error_message = "Invalid input, valid input options are: physicalSharing, virtualSharing or noSharing."
  }
  default = "noSharing"
}

variable "storage_policy_id" {
  description = "The ID of the storage policy to assign to the home directory of a virtual machine."
  type        = string
  default     = null
}

variable "tags" {
  description = "The IDs of any tags to attach to this resource. Please refer to the vsphere_tag resource for more information on applying tags to virtual machine resources."
  type        = set(string)
  default     = null
}

variable "vapp_block" {
  description = "Used for vApp configurations. The only sub-key available is properties, which is a key/value map of properties for virtual machines imported from and OVF/OVA."
  type        = map(object({
    properties = string
    guestinfo  = set(object({
      "guestinfo.hostname"  = string
      "guestinfo.ipaddress" = string
      "guestinfo.netmask"   = string
      "guestinfo.gateway"   = string
      "guestinfo.dns"       = string
      "guestinfo.domain"    = string
      "guestinfo.ntp"       = string
      "guestinfo.password"  = string
      "guestinfo.ssh"       = bool
    }))
  }))
  default = null
}

variable "num_cpus" {
  description = "The total number of virtual processor cores to assign to the virtual machine. Default: 1."
  type        = number
  default     = 1
}

variable "memory" {
  description = "The memory size to assign to the virtual machine, in MB. Default: 1024 (1 GB)."
  type        = number
  default     = 1024
}

variable "disk_label" {
  description = "A label for the virtual disk. Forces a new disk, if changed."
  type        = string
  default     = "disk0"
}

variable "disk_size" {
  description = "The size of the disk, in GB. Must be a whole number."
  type        = number
  default     = 20
}

variable "thin_provisioned" {
  description = "With the disk-level thin provisioning feature, you can create virtual disks in a thin format."
  type        = bool
  default     = true
}

variable "extra_config" {
  description = "Extra configuration data for the virtual machine."
  type        = object({})
  default     = null
}

variable "firmware" {
  description = "The firmware for the virtual machine."
  type        = string
  validation {
    condition     = contains(["bios", "efi"], lower(var.firmware))
    error_message = "Invalid input, valid input options are: bios, efi."
  }
  default = "efi"
}

variable "folder" {
  description = "The path to the virtual machine folder in which to place the virtual machine, relative to the datacenter path (/<datacenter-name>/vm)."
  type        = string
  default     = null
}

variable "guest_id" {
  description = "The vsphere_virtual_machine data source can be used to find the UUID of an existing virtual machine or template."
  type        = string
}

variable "hardware_version" {
  description = "hardware_version Valid range is from 4 to 19."
  type        = number
  validation {
    condition = (
    var.hardware_version >= 4 &&
    var.hardware_version <= 19
    )
    error_message = "hardware_version must be between 4-19."
  }
  default = 19
}

variable "host_system_id" {
  description = "The managed object reference ID of a host on which to place the virtual machine."
  type        = string
  default     = null
}

variable "name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "network_interface_block" {
  description = "A specification for a virtual NIC on the virtual machine."
  type        = object({
    network_id            = string
    adapter_type          = optional(string)
    use_static_mac        = optional(bool)
    mac_address           = optional(string)
    bandwidth_limit       = optional(number)
    bandwidth_reservation = optional(number)
    bandwidth_share_level = optional(string)
    bandwidth_share_count = optional(number)
    ovf_mapping           = optional(string)
  })
  default = null
}

variable "pci_device_id" {
  description = "List of host PCI device IDs in which to create PCI passthroughs."
  type        = set(string)
  default     = null
}

variable "ovf_deploy_block" {
  description = "When specified, the virtual machine will be deployed from the provided OVF/OVA template."
  type        = object({
    allow_unverified_ssl_cert = optional(bool)
    enable_hidden_properties  = optional(bool)
    local_ovf_path            = optional(string)
    remote_ovf_url            = optional(string)
    ip_allocation_policy      = optional(string)
    ip_protocol               = optional(string)
    disk_provisioning         = optional(string)
    deployment_option         = optional(string)
    ovf_network_map           = optional(string)
  })
  default = null
}

variable "replace_trigger" {
  description = "Triggers replacement of resource whenever it changes."
  type        = string
  default     = null
}

variable "resource_pool_id" {
  description = "The managed object reference ID of the resource pool in which to place the virtual machine."
  type        = string
}

variable "sync_time_with_host" {
  description = "Enable the guest operating system to synchronization its clock with the host when the virtual machine is powered on or resumed."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.sync_time_with_host))
    error_message = "Invalid input, valid input options are boolean: true or false."
  }
  default = true
}

variable "wait_for_guest_net_timeout" {
  description = "The amount of time, in minutes, to wait for an available guest IP address on the virtual machine."
  type        = number
  default     = 0
}

variable "efi_secure_boot_enabled" {
  description = "Use this option to enable EFI secure boot when the firmware type is set to is efi."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.efi_secure_boot_enabled))
    error_message = "Invalid input, valid input options are boolean: true, false."
  }
  default = false
}