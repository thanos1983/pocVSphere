resource "vsphere_virtual_machine" "virtual_machine" {
  alternate_guest_name = var.alternate_guest_name
  annotation           = var.annotation

  dynamic "cdrom" {
    for_each = var.cdrom_block[*]
    content {
      datastore_id = cdrom.value.datastore_id
      path         = cdrom.value.path
    }
  }

  dynamic "clone" {
    for_each = var.clone_block[*]
    content {
      template_uuid = clone.value.template_uuid
      linked_clone  = clone.value.linked_clone
      timeout       = clone.value.timeout
      dynamic "customize" {
        for_each = clone.value.customize_block[*]
        content {
          timeout = customize.value.timeout
          dynamic "network_interface" {
            for_each = customize.value.network_interface_block[*]
            content {
              dns_server_list = network_interface.value.dns_server_list
              dns_domain      = network_interface.value.dns_domain
              ipv4_address    = network_interface.value.ipv4_address
              ipv4_netmask    = network_interface.value.ipv4_netmask
              ipv6_address    = network_interface.value.ipv6_address
              ipv6_netmask    = network_interface.value.ipv6_netmask
            }
          }
          ipv4_gateway    = customize.value.ipv4_gateway
          ipv6_gateway    = customize.value.ipv6_gateway
          dns_server_list = customize.value.dns_server_list
          dns_suffix_list = customize.value.dns_suffix_list
          dynamic "linux_options" {
            for_each = customize.value.linux_options_block[*]
            content {
              host_name    = linux_options.value.host_name
              domain       = linux_options.value.domain
              hw_clock_utc = linux_options.value.hw_clock_utc
              script_text  = linux_options.value.script_text
              time_zone    = linux_options.value.time_zone
            }
          }
          dynamic "windows_options" {
            for_each = customize.value.windows_options_block[*]
            content {
              computer_name         = windows_options.value.computer_name
              admin_password        = windows_options.value.admin_password
              workgroup             = windows_options.value.workgroup
              join_domain           = windows_options.value.join_domain
              domain_admin_user     = windows_options.value.domain_admin_user
              domain_admin_password = windows_options.value.domain_admin_password
              full_name             = windows_options.value.full_name
              organization_name     = windows_options.value.organization_name
              product_key           = windows_options.value.product_key
              run_once_command_list = windows_options.value.run_once_command_list
              auto_logon            = windows_options.value.auto_logon
              auto_logon_count      = windows_options.value.auto_logon_count
              time_zone             = windows_options.value.time_zone
            }
          }
          windows_sysprep_text = customize.value.windows_sysprep_text
        }
      }
    }
  }

  extra_config_reboot_required = var.extra_config_reboot_required
  custom_attributes            = var.custom_attributes
  datastore_id                 = var.datastore_id
  datastore_cluster_id         = var.datastore_cluster_id
  datacenter_id                = var.datacenter_id

  disk {
    label            = var.disk_label
    size             = var.disk_size
    thin_provisioned = var.thin_provisioned
  }

  extra_config     = var.extra_config
  firmware         = var.firmware
  folder           = var.folder
  guest_id         = var.guest_id
  hardware_version = var.hardware_version
  host_system_id   = var.host_system_id
  name             = var.name

  dynamic "network_interface" {
    for_each = var.network_interface_block[*]
    content {
      network_id            = network_interface.value.network_id
      adapter_type          = network_interface.value.adapter_type
      use_static_mac        = network_interface.value.use_static_mac
      mac_address           = network_interface.value.mac_address
      bandwidth_limit       = network_interface.value.bandwidth_limit
      bandwidth_reservation = network_interface.value.bandwidth_reservation
      bandwidth_share_level = network_interface.value.bandwidth_share_level
      ovf_mapping           = network_interface.value.ovf_mapping
    }
  }

  pci_device_id = var.pci_device_id

  dynamic "ovf_deploy" {
    for_each = var.ovf_deploy_block[*]
    content {
      allow_unverified_ssl_cert = ovf_deploy.value.allow_unverified_ssl_cert
      enable_hidden_properties  = ovf_deploy.value.enable_hidden_properties
      local_ovf_path            = ovf_deploy.value.local_ovf_path
      remote_ovf_url            = ovf_deploy.value.remote_ovf_url
      ip_allocation_policy      = ovf_deploy.value.ip_allocation_policy
      ip_protocol               = ovf_deploy.value.ip_protocol
      disk_provisioning         = ovf_deploy.value.disk_provisioning
      deployment_option         = ovf_deploy.value.deployment_option
      ovf_network_map           = ovf_deploy.value.ovf_network_map
    }
  }

  replace_trigger   = var.replace_trigger
  resource_pool_id  = var.resource_pool_id
  scsi_type         = var.scsi_type
  scsi_bus_sharing  = var.scsi_bus_sharing
  storage_policy_id = var.storage_policy_id
  tags              = var.tags

  dynamic "vapp" {
    for_each = var.vapp_block[*]
    content {
      properties = vapp.value.properties
    }
  }

  cpu_hot_add_enabled        = var.cpu_hot_add_enabled

  wait_for_guest_net_timeout = var.wait_for_guest_net_timeout
  sync_time_with_host        = var.sync_time_with_host
  num_cpus                   = var.num_cpus
  memory                     = var.memory
  efi_secure_boot_enabled    = var.efi_secure_boot_enabled
}

# sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y && sudo apt-get autoclean -y