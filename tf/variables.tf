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
  type        = bool
  default     = true
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

variable "vsphere_virtual_machine_ubuntu_jammy" {
  description = "The vsphere_virtual_machine data source can be used to find the UUID of an existing virtual machine or template."
  default     = "ubuntu64Guest"
  type        = string
}

variable "vsphere_virtual_machine_windows_id" {
  description = "The vsphere_virtual_machine data source can be used to find the UUID of an existing virtual machine or template."
  default     = "windows7_64Guest"
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