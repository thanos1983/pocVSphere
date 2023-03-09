output "id" {
  description = "The UUID of the virtual machine."
  value       = vsphere_virtual_machine.virtual_machine.id
}

output "reboot_required" {
  description = "Value internal to Terraform used to determine if a configuration set change requires a reboot."
  value       = vsphere_virtual_machine.virtual_machine.reboot_required
}

output "vmware_tools_status" {
  description = "The state of VMware Tools in the guest."
  value       = vsphere_virtual_machine.virtual_machine.vmware_tools_status
}

output "vmx_path" {
  description = "The path of the virtual machine configuration file on the datastore in which the virtual machine is placed."
  value       = vsphere_virtual_machine.virtual_machine.vmx_path
}

output "imported" {
  description = "Indicates if the virtual machine resource has been imported, or if the state has been migrated from a previous version of the resource."
  value       = vsphere_virtual_machine.virtual_machine.imported
}

output "change_version" {
  description = "A unique identifier for a given version of the last configuration was applied."
  value       = vsphere_virtual_machine.virtual_machine.change_version
}

output "uuid" {
  description = "The UUID of the virtual machine."
  value       = vsphere_virtual_machine.virtual_machine.uuid
}

output "default_ip_address" {
  description = "The IP address selected by Terraform to be used with any [provisioners][tf-docs-provisioners] configured on this resource."
  value       = vsphere_virtual_machine.virtual_machine.default_ip_address
}

output "guest_ip_addresses" {
  description = "The current list of IP addresses on this machine, including the value of default_ip_address."
  value       = vsphere_virtual_machine.virtual_machine.guest_ip_addresses
}

output "moid" {
  description = "The managed object reference ID of the created virtual machine."
  value       = vsphere_virtual_machine.virtual_machine.moid
}

output "vapp_transport" {
  description = "Computed value which is only valid for cloned virtual machines."
  value       = vsphere_virtual_machine.virtual_machine.vapp_transport
}

output "power_state" {
  description = "A computed value for the current power state of the virtual machine."
  value       = vsphere_virtual_machine.virtual_machine.power_state
}

output "name" {
  description = "The name of the virtual machine."
  value = vsphere_virtual_machine.virtual_machine.name
}