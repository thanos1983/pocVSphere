resource "vsphere_virtual_machine" "vm" {
  alternate_guest_name = var.alternate_guest_name
  annotation           = var.annotation

  dynamic "cdrom" {
    for_each = var.cdrom_content[*]
    content {
      datastore_id = cdrom.value.datastore_id
      path         = cdrom.value.path
    }
  }

  dynamic "clone" {
    for_each = var.clone_content[*]
    content {
      template_uuid = clone.value.template_uuid
      linked_clone  = clone.value.linked_clone
      timeout       = clone.value.timeout
      dynamic "customize" {
        for_each = clone.value.customize_content[*]
        content {
          timeout = customize.value.timeout
          dynamic "network_interface" {
            for_each = clone.value.network_interfaces
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
            for_each = clone.value.linux_options_block
            content {
              host_name    = linux_options.value.host_name
              domain       = linux_options.value.domain
              hw_clock_utc = linux_options.value.hw_clock_utc
              script_text  = linux_options.value.script_text
              time_zone    = linux_options.value.time_zone
            }
          }
          dynamic "windows_options" {
            for_each = clone.value.windows_options_block
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

  wait_for_guest_net_timeout = var.wait_for_guest_net_timeout
  sync_time_with_host        = var.sync_time_with_host
  resource_pool_id           = var.resource_pool_id
  datastore_id               = var.datastore_id
  guest_id                   = var.guest_id
  num_cpus                   = var.num_cpus
  memory                     = var.memory
  name                       = var.name

  dynamic "network_interface" {
    for_each = var.network_interfaces
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

  disk {
    label            = var.disk_label
    size             = var.disk_size
    thin_provisioned = var.thin_provisioned
  }

  lifecycle {
    ignore_changes = [
      cdrom
    ]
  }

}