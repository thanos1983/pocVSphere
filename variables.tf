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
