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

variable "cdrom_content" {
  description = "A specification for a CD-ROM device on the virtual machine."
  type        = object({
    datastore_id = string
    path         = string
  })
  default = {
    datastore_id = null
    path         = null
  }
}

variable "clone_content" {
  description = "The clone block can be used to create a new virtual machine from an existing virtual machine or template."
  type        = object({
    template_uuid     = optional(string)
    linked_clone      = optional(string)
    timeout           = optional(number)
    customize_content = optional(object({
      timeout            = optional(number, 10)
      network_interfaces = optional(list(object({
        dns_server_list = optional(string)
        dns_domain      = optional(string)
        ipv4_address    = optional(string)
        ipv4_netmask    = optional(number)
        ipv6_address    = optional(string)
        ipv6_netmask    = optional(number)
      })), [])
      ipv4_gateway        = optional(string)
      ipv6_gateway        = optional(string)
      dns_server_list     = optional(string)
      dns_suffix_list     = optional(string)
      linux_options_block = optional(object({
        host_name    = optional(string)
        domain       = optional(string)
        hw_clock_utc = optional(bool, true)
        script_text  = optional(string)
        time_zone    = optional(string)
      }), {})
      windows_options_block = optional(object({
        computer_name         = optional(string)
        admin_password        = optional(string)
        workgroup             = optional(string)
        join_domain           = optional(string)
        domain_admin_user     = optional(string)
        domain_admin_password = optional(string)
        full_name             = optional(string)
        organization_name     = optional(string)
        product_key           = optional(string)
        run_once_command_list = optional(list(string))
        auto_logon            = optional(bool, false)
        auto_logon_count      = optional(number, 1)
        time_zone             = optional(number, 85)
      }), {})
      windows_sysprep_text = optional(string)
    }), {})
  })
  default = null
}

variable "name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "network_interfaces" {
  description = "A specification for a virtual NIC on the virtual machine."
  type        = list(object({
    network_id            = optional(string)
    adapter_type          = optional(string)
    use_static_mac        = optional(bool)
    mac_address           = optional(string)
    bandwidth_limit       = optional(number)
    bandwidth_reservation = optional(number)
    bandwidth_share_level = optional(string)
    bandwidth_share_count = optional(number)
    ovf_mapping           = optional(string)
  }))
  default = []
}

variable "resource_pool_id" {
  description = "The managed object reference ID of the resource pool in which to place the virtual machine."
  type        = string
}

variable "datastore_id" {
  description = "The datastore ID that on which the ISO is located. Required for using a datastore ISO."
  type        = string
}

variable "vsphere_datacenter" {
  description = "This is the vCenter Server FQDN or IP Address for vSphere API operations. Can also be specified with the VSPHERE_SERVER environment variable."
  default     = "Datacenter"
  type        = string
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

variable "guest_id" {
  description = "The vsphere_virtual_machine data source can be used to find the UUID of an existing virtual machine or template."
  type        = string
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

variable "sync_time_with_host" {
  description = "Enable the guest operating system to synchronization its clock with the host when the virtual machine is powered on or resumed."
  validation {
    condition     = contains(["true", "false"], tostring(var.sync_time_with_host))
    error_message = "Invalid input, valid input options are boolean: true or false."
  }
  type    = bool
  default = true
}

variable "wait_for_guest_net_timeout" {
  description = "The amount of time, in minutes, to wait for an available guest IP address on the virtual machine."
  type        = number
  default     = 0
}