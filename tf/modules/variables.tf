variable "alternate_guest_name" {
  description = "The guest name for the operating system when guest_id is otherGuest or otherGuest64."
  type        = string
  default     = null
}

variable "name" {
  description = "The name of the virtual machine."
  type        = string
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

variable "network_interface_network_id" {
  description = "The managed object reference ID of the network on which to connect the virtual machine network interface."
  type        = string
}

variable "cdrom_datastore_id" {
  description = "The datastore ID that on which the ISO is located. Required for using a datastore ISO."
  type        = string
}

variable "cdrom_path" {
  description = "The path to the ISO file. Required for using a datastore ISO."
  type        = string
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

variable "sync_time_with_host" {
  description = "Enable the guest operating system to synchronization its clock with the host when the virtual machine is powered on or resumed."
  validation {
    condition     = contains(["true", "false"], tostring(var.sync_time_with_host))
    error_message = "Invalid input, valid input options are boolean: true, false."
  }
  type    = bool
  default = true
}

variable "wait_for_guest_net_timeout" {
  description = "The amount of time, in minutes, to wait for an available guest IP address on the virtual machine."
  type        = number
  default     = 0
}