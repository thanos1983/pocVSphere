variable "name" {
  description = "Name of the VM."
  type        = string
  default     = "ubuntu-server-template-demo"
}

variable "name-template" {
  description = "Name of the VM Template."
  type        = string
  default     = "ubuntu-server-template-new"
}

variable "vsphere_user" {
  description = "This is the username for vSphere API operations. Can also be specified with the VSPHERE_USER environment variable."
  type        = string
  sensitive   = true
}

variable "vsphere_password" {
  description = "This is the password for vSphere API operations. Can also be specified with the VSPHERE_PASSWORD environment variable."
  type        = string
  sensitive   = true
}

variable "vsphere_server" {
  description = "This is the vCenter Server FQDN or IP Address for vSphere API operations. Can also be specified with the VSPHERE_SERVER environment variable."
  default     = "10.98.135.11"
  type        = string
  sensitive   = true
}

variable "allow_unverified_ssl" {
  description = "Boolean that can be set to true to disable SSL certificate verification. This should be used with care as it could allow an attacker to intercept your authentication token. If omitted, default value is false."
  validation {
    condition     = contains(["true", "false"], tostring(var.allow_unverified_ssl))
    error_message = "Invalid input, valid input options are boolean: true, false."
  }
  type    = bool
  default = true
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

variable "sync_time_with_host" {
  description = "Enable the guest operating system to synchronization its clock with the host when the virtual machine is powered on or resumed."
  validation {
    condition     = contains(["true", "false"], tostring(var.sync_time_with_host))
    error_message = "Invalid input, valid input options are boolean: true, false."
  }
  type    = bool
  default = true
}

variable "disk_label" {
  description = "A label for the virtual disk. Forces a new disk, if changed."
  type        = string
  default     = "disk0"
}

variable "wait_for_guest_net_timeout" {
  description = "The amount of time, in minutes, to wait for an available guest IP address on the virtual machine."
  type        = number
  default     = 0
}