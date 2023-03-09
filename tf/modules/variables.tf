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
    client_device = optional(string)
    datastore_id  = string
    path          = string
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

variable "disk_block" {
  description = "Virtual disks are managed by adding one or more instance of the disk block."
  type        = object({
    label             = string
    size              = number
    unit_number       = optional(number)
    datastore_id      = optional(string)
    attach            = optional(bool)
    path              = optional(string)
    keep_on_remove    = optional(bool)
    disk_mode         = optional(string)
    eagerly_scrub     = optional(bool)
    thin_provisioned  = optional(bool)
    disk_sharing      = optional(string)
    write_through     = optional(bool)
    io_limit          = optional(number)
    io_reservation    = optional(number)
    io_share_level    = optional(string)
    io_share_count    = optional(number)
    storage_policy_id = optional(string)
    controller_type   = optional(string)
  })
  default = null
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
  description = "The ovf_deploy block is used to create a new virtual machine from an OVF/OVA template from either local system or remote URL."
  type        = object({
    allow_unverified_ssl_cert = optional(bool)
    enable_hidden_properties  = optional(bool)
    local_ovf_path            = optional(string)
    remote_ovf_url            = optional(string)
    ip_allocation_policy      = optional(string)
    ip_protocol               = optional(string)
    disk_provisioning         = optional(string)
    deployment_option         = optional(string)
    ovf_network_map           = optional(map(string))
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
  description = " Used for vApp configurations. The only sub-key available is properties, which is a key/value map of properties for virtual machines imported from and OVF/OVA."
  type        = object({
    properties = object({})
  })
  default = null
}

variable "cpu_hot_add_enabled" {
  description = "Allow CPUs to be added to the virtual machine while it is powered on."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.cpu_hot_add_enabled))
    error_message = "Invalid input, valid input options are boolean: true or false."
  }
  default = true
}

variable "cpu_hot_remove_enabled" {
  description = "Allow CPUs to be removed to the virtual machine while it is powered on."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.cpu_hot_remove_enabled))
    error_message = "Invalid input, valid input options are boolean: true or false."
  }
  default = true
}

variable "memory" {
  description = "The memory size to assign to the virtual machine, in MB. Default: 1024 (1 GB)."
  type        = number
  default     = 1024
}

variable "memory_hot_add_enabled" {
  description = "Allow memory to be added to the virtual machine while it is powered on."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.memory_hot_add_enabled))
    error_message = "Invalid input, valid input options are boolean: true or false."
  }
  default = true
}

variable "num_cores_per_socket" {
  description = "The number of cores per socket in the virtual machine."
  type        = number
  default     = 1
}

variable "num_cpus" {
  description = "The total number of virtual processor cores to assign to the virtual machine. Default: 1."
  type        = number
  default     = 1
}

variable "boot_delay" {
  description = "The number of milliseconds to wait before starting the boot sequence."
  type        = number
  default     = 0
}

variable "boot_retry_delay" {
  description = "The number of milliseconds to wait before retrying the boot sequence."
  type        = number
  default     = 10000
}

variable "boot_retry_enabled" {
  description = "If set to true, a virtual machine that fails to boot will try again after the delay defined in boot_retry_delay."
  type        = bool
  default     = false

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

variable "run_tools_scripts_after_power_on" {
  description = "Enable post-power-on scripts to run when VMware Tools is installed."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.run_tools_scripts_after_power_on))
    error_message = "Invalid input, valid input options are boolean: true, false."
  }
  default = true
}

variable "run_tools_scripts_after_resume" {
  description = "Enable ost-resume scripts to run when VMware Tools is installed."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.run_tools_scripts_after_resume))
    error_message = "Invalid input, valid input options are boolean: true, false."
  }
  default = true
}

variable "run_tools_scripts_before_guest_reboot" {
  description = "Enable pre-reboot scripts to run when VMware Tools is installed."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.run_tools_scripts_before_guest_reboot))
    error_message = "Invalid input, valid input options are boolean: true, false."
  }
  default = false
}

variable "run_tools_scripts_before_guest_shutdown" {
  description = "Enable pre-shutdown scripts to run when VMware Tools is installed."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.run_tools_scripts_before_guest_shutdown))
    error_message = "Invalid input, valid input options are boolean: true, false."
  }
  default = true
}

variable "run_tools_scripts_before_guest_standby" {
  description = "Enable pre-standby scripts to run when VMware Tools is installed."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.run_tools_scripts_before_guest_standby))
    error_message = "Invalid input, valid input options are boolean: true, false."
  }
  default = true
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

variable "sync_time_with_host_periodically" {
  description = "Enable the guest operating system to periodically synchronize its clock with the host."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.sync_time_with_host_periodically))
    error_message = "Invalid input, valid input options are boolean: true or false."
  }
  default = false
}

variable "tools_upgrade_policy" {
  description = "Enable automatic upgrade of the VMware Tools version when the virtual machine is rebooted."
  type        = string
  validation {
    condition     = contains(["manual", "upgradeAtPowerCycle"], var.tools_upgrade_policy)
    error_message = "Invalid input, valid input options are: manual or upgradeAtPowerCycle."
  }
  default = "manual"
}

variable "cpu_limit" {
  description = "The maximum amount of CPU (in MHz) that the virtual machine can consume, regardless of available resources."
  type        = number
  default     = null
}

variable "cpu_reservation" {
  description = "The amount of CPU (in MHz) that the virtual machine is guaranteed."
  type        = number
  default     = null
}

variable "cpu_share_level" {
  description = "The allocation level for the virtual machine CPU resources."
  type        = string
  validation {
    condition     = contains(["high", "low", "normal", "custom"], lower(var.cpu_share_level))
    error_message = "Invalid input, valid input options are: high, low, normal or custom."
  }
  default = "custom"
}

variable "cpu_share_count" {
  description = "The number of CPU shares allocated to the virtual machine when the cpu_share_level is custom."
  type        = number
  default     = null
}

variable "memory_limit" {
  description = "The maximum amount of memory (in MB) that th virtual machine can consume, regardless of available resources."
  type        = number
  default     = null
}

variable "memory_reservation" {
  description = "The amount of memory (in MB) that the virtual machine is guaranteed."
  type        = number
  default     = null
}

variable "memory_share_level" {
  description = "The allocation level for the virtual machine memory resources."
  type        = string
  validation {
    condition     = contains(["high", "low", "normal", "custom"], lower(var.memory_share_level))
    error_message = "Invalid input, valid input options are: high, low, normal or custom."
  }
  default = "custom"
}

variable "memory_share_count" {
  description = "The number of memory shares allocated to the virtual machine when the memory_share_level is custom."
  type        = number
  default     = null
}

variable "cpu_performance_counters_enabled" {
  description = "Enable CPU performance counters on the virtual machine."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.cpu_performance_counters_enabled))
    error_message = "Invalid input, valid input options are boolean: true or false."
  }
  default = false
}

variable "enable_disk_uuid" {
  description = "Expose the UUIDs of attached virtual disks to the virtual machine, allowing access to them in the guest."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.enable_disk_uuid))
    error_message = "Invalid input, valid input options are boolean: true or false."
  }
  default = false
}

variable "enable_logging" {
  description = "Enable logging of virtual machine events to a log file stored in the virtual machine directory."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.enable_logging))
    error_message = "Invalid input, valid input options are boolean: true or false."
  }
  default = false
}

variable "ept_rvi_mode" {
  description = "The EPT/RVI (hardware memory virtualization) setting for the virtual machine."
  type        = string
  validation {
    condition     = contains(["automatic", "on", "off"], lower(var.ept_rvi_mode))
    error_message = "Invalid input, valid input options are: automatic, on or off."
  }
  default = "automatic"
}

variable "force_power_off" {
  description = "If a guest shutdown failed or times out while updating or destroying (see shutdown_wait_timeout), force the power-off of the virtual machine."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.force_power_off))
    error_message = "Invalid input, valid input options are boolean: true or false."
  }
  default = true
}

variable "hv_mode" {
  description = "The hardware virtualization (non-nested) setting for the virtual machine."
  type        = string
  validation {
    condition     = contains(["hvAuto", "hvOn", "hvOff"], var.hv_mode)
    error_message = "Invalid input, valid input options are: hvAuto, hvOn or hvOff."
  }
  default = "hvAuto"
}

variable "ide_controller_count" {
  description = "The number of IDE controllers that the virtual machine."
  type        = number
  default     = 2
}

variable "ignored_guest_ips" {
  description = "List of IP addresses and CIDR networks to ignore while waiting for an available IP address using either of the waiters."
  type        = set(string)
  default     = null
}

variable "latency_sensitivity" {
  description = "Controls the scheduling delay of the virtual machine."
  type        = string
  validation {
    condition     = contains(["low", "normal", "medium", "high"], lower(var.latency_sensitivity))
    error_message = "Invalid input, valid input options are: low, normal, medium or high."
  }
  default = "normal"
}

variable "migrate_wait_timeout" {
  description = "The amount of time, in minutes, to wait for a virtual machine migration to complete before failing."
  type        = number
  default     = 10
}

variable "nested_hv_enabled" {
  description = "Enable nested hardware virtualization on the virtual machine, facilitating nested virtualization in the guest operating system."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.nested_hv_enabled))
    error_message = "Invalid input, valid input options are boolean: true or false."
  }
  default = false
}

variable "shutdown_wait_timeout" {
  description = "The amount of time, in minutes, to wait for a graceful guest shutdown when making necessary updates to the virtual machine."
  type        = number
  default     = 3
}

variable "swap_placement_policy" {
  description = "The swap file placement policy for the virtual machine."
  type        = string
  validation {
    condition     = contains(["inherit", "hostLocal", "vmDirectory"], lower(var.swap_placement_policy))
    error_message = "Invalid input, valid input options are: inherit, hostLocal or vmDirectory."
  }
  default = "inherit"
}

variable "vbs_enabled" {
  description = "Enable Virtualization Based Security."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.vbs_enabled))
    error_message = "Invalid input, valid input options are boolean: true or false."
  }
  default = false
}

variable "vvtd_enabled" {
  description = "Enable Intel Virtualization Technology for Directed I/O for the virtual machine (I/O MMU in the vSphere Client)."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.vvtd_enabled))
    error_message = "Invalid input, valid input options are boolean: true or false."
  }
  default = false
}

variable "wait_for_guest_ip_timeout" {
  description = "The amount of time, in minutes, to wait for an available guest IP address on the virtual machine."
  type        = number
  default     = 0
}

variable "wait_for_guest_net_routable" {
  description = "Controls whether or not the guest network waiter waits for a routable address."
  type        = bool
  validation {
    condition     = contains(["true", "false"], tostring(var.wait_for_guest_net_routable))
    error_message = "Invalid input, valid input options are boolean: true or false."
  }
  default = true
}

variable "wait_for_guest_net_timeout" {
  description = "The amount of time, in minutes, to wait for an available guest IP address on the virtual machine."
  type        = number
  default     = 5
}