# pocVSphere

Create / Destroy resources with terraform for VSphere

## Prerequisites

### Packages Ubuntu

The user needs to install the `sshpass` package for ssh username / keys. It is also recommended to install `docker`
and `docker-compose` packages. Sample:

```bash
sudo apt-get install sshpass -y
```

For Ubuntu the documentation can be found
here: [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/).

Assuming the user has followed all the steps as described above sample of command for installing the packages:

```shell
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
```

For ease of use it is recommended that the user will also apply
the [Docker Engine post-installation steps](https://docs.docker.com/engine/install/linux-postinstall/).

The user if desires to generate Let's Encrypt certificates they need to follow the steps bellow:

- sudo apt install snapd # Install snapd
- sudo snap install core; sudo snap refresh core # Ensure you have the latest snapd version installed
- sudo snap install --classic certbot # Install Certbot with snapd
- sudo ln -s /snap/bin/certbot /usr/bin/certbot # Create a symlink to ensure Certbot runs

### Packages Ansible

The user needs to install the python package for encryption / descryption and also aiohttp for vmware. Sample:

- Ansible packages
    1. aiohttp
    2. cryptography

The packages can be either installed by `pip`:

```bash
pip3 install cryptography aiohttp docker docker-compose botocore boto3 hvac --upgrade
```

Or by `Ansible` packages:

```shell
ansible-galaxy collection install community.crypto
ansible-galaxy collection install vmware.vmware_rest
```

### Caution

On this module we have used self-signed certificates. S3 buckets (Amazon) do not allow connection with non-certified SSL
providers, hence the self-signed certificates are not allowed to connect with S3 bucket. As a workaround the user can
copy the public key from the generated (dedicated directory) to the certificates directory and update the certificates
list in order to include it (locally) as approved certificate.

The procedure differs per Linux vendor. On this tutorial we will demonstrate how it can by accomplished in Ubuntu (
Debian based) Operating System (OS).

We could automate this procedure through Ansible but it would also require elevated access, hence we decided not apply
it as we want the playbook to be non-root user executable.

Sample of manual steps of copying the CA to local approved certificates:

```shell
sudo cp /home/<user>/s3DemoDir/certs/public.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates --fresh
sudo dpkg-reconfigure ca-certificates
```

After the user should be able to use `terraform init -reconfigure` to allow local CA to be used towards S3 bucket (
minio).

Sample of expected output:

```shell
$ terraform init -reconfigure
Initializing modules...

Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of hashicorp/vsphere from the dependency lock file
- Using previously-installed hashicorp/vsphere v2.2.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

### How to export variables to Environment Variables due to sensitive information

Sample of the procedure:

```bash
$ export ACCESS_KEY="minioadmin"
$ export SECRET_KEY="minioadmin"
```

As a next step the user can then use them through the init procedure. Sample of procedure:

```bash
$ terraform init -reconfigure -backend-config="access_key=${ACCESS_KEY}" -backend-config="secret_key=${SECRET_KEY}"
```

If the user observes the error:

```bash
$ ansible-vault encrypt terraform-role/vars/secure-vars.yml
New Vault password: # manual input
Confirm New Vault password: # manual input
ERROR! ansible-vault requires the cryptography library in order to function
```

Then simply encode the file sample:

```bash
$ ansible-vault encrypt terraform-role/vars/secure-vars.yml
New Vault password: # manual input
Confirm New Vault password: # manual input
Encryption successful
$ cat terraform-role/secrets/secure-vars.yml
$ANSIBLE_VAULT;1.1;AES256
37353362306165316664383932326332323332656136306265656661396131333764336166613064
6636376366363264376461376630326361386231653763350a663665356236653336643938646433
61653366383930363238333238623964653936383637633034323936333966306564326330353738
3335313162363863370a396664646230386633396530353865333238346330316131633539643462
66663536373138396538653865613538316437376138353666616531393763623264316436316639
65376235663039396331373832633430626661333735643565316132313362363939303639313034
34363931396139616363363533646531396537643731393334373566346462643834336262656165
37323762633533316333623032666364303933363036653736383664326435356233663937386139
62343832663039613861613534313737333062396334383435656632313632666530
```

### Terraform

Sample of the directory after clone of the project:

```shell
$ ls -la
total 64
drwxr-xr-x  5 tinyos tinyos  4096 Jan 24 12:41 .
drwxr-xr-x 18 tinyos tinyos  4096 Jan 24 10:15 ..
drwxr-xr-x  8 tinyos tinyos  4096 Jan 24 10:16 .git
-rw-r--r--  1 tinyos tinyos   849 Jan 24 10:04 .gitignore
drwxr-xr-x  3 tinyos tinyos  4096 Jan 24 12:35 .terraform
-rw-r--r--  1 tinyos tinyos 11357 Jan 23 17:28 LICENSE
-rw-r--r--  1 tinyos tinyos  3933 Jan 24 12:40 README.md
-rw-r--r--  1 tinyos tinyos   207 Jan 23 16:40 ansible.cfg
-rw-r--r--  1 tinyos tinyos   963 Jan 24 11:27 local.tf
-rw-r--r--  1 tinyos tinyos   463 Jan 24 11:27 main.tf
-rw-r--r--  1 tinyos tinyos   205 Jan 23 12:50 provider.tf
drwxr-xr-x  2 tinyos tinyos  4096 Jan 24 10:13 terraformVars
-rw-r--r--  1 tinyos tinyos  2529 Jan 24 11:19 variables.tf
-rw-r--r--  1 tinyos tinyos   129 Jan 23 14:19 versions.tf
```

Initialize the working directory containing Terraform files. Sample:

```shell
$ terraform -chdir=tf/ init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/vsphere...
- Installing hashicorp/vsphere v2.2.0...
- Installed hashicorp/vsphere v2.2.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

The user can create an execution plan of their infrastructure based on the Terraform configuration(s)  file(s). Sample:

```shell
$ terraform -chdir=tf/ plan -out=planOutput -var-file=tfvars/dev.tfvars
data.vsphere_datacenter.datacenter: Reading...
data.vsphere_datacenter.datacenter: Read complete after 0s [id=datacenter-3]
data.vsphere_network.network_dns: Reading...
data.vsphere_compute_cluster.cluster: Reading...
data.vsphere_network.network: Reading...
data.vsphere_datastore.datastore: Reading...
data.vsphere_datastore.datastore: Read complete after 0s [id=datastore-17]
data.vsphere_network.network_dns: Read complete after 0s [id=network-19]
data.vsphere_network.network: Read complete after 0s [id=network-18]
data.vsphere_compute_cluster.cluster: Read complete after 0s [id=domain-c8]

Terraform used the selected providers to generate the following execution plan. Resource
actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # vsphere_virtual_machine.vm will be created
  + resource "vsphere_virtual_machine" "vm" {
      + annotation                              = (known after apply)
      + boot_retry_delay                        = 10000
      + change_version                          = (known after apply)
      + cpu_limit                               = -1
      + cpu_share_count                         = (known after apply)
      + cpu_share_level                         = "normal"
      + datastore_id                            = "datastore-17"
      + default_ip_address                      = (known after apply)
      + ept_rvi_mode                            = "automatic"
      + firmware                                = "bios"
      + force_power_off                         = true
      + guest_id                                = "other3xLinux64Guest"
      + guest_ip_addresses                      = (known after apply)
      + hardware_version                        = (known after apply)
      + host_system_id                          = (known after apply)
      + hv_mode                                 = "hvAuto"
      + id                                      = (known after apply)
      + ide_controller_count                    = 2
      + imported                                = (known after apply)
      + latency_sensitivity                     = "normal"
      + memory                                  = 1024
      + memory_limit                            = -1
      + memory_share_count                      = (known after apply)
      + memory_share_level                      = "normal"
      + migrate_wait_timeout                    = 30
      + moid                                    = (known after apply)
      + name                                    = "foo"
      + num_cores_per_socket                    = 1
      + num_cpus                                = 1
      + power_state                             = (known after apply)
      + poweron_timeout                         = 300
      + reboot_required                         = (known after apply)
      + resource_pool_id                        = "resgroup-9"
      + run_tools_scripts_after_power_on        = true
      + run_tools_scripts_after_resume          = true
      + run_tools_scripts_before_guest_shutdown = true
      + run_tools_scripts_before_guest_standby  = true
      + sata_controller_count                   = 0
      + scsi_bus_sharing                        = "noSharing"
      + scsi_controller_count                   = 1
      + scsi_type                               = "pvscsi"
      + shutdown_wait_timeout                   = 3
      + storage_policy_id                       = (known after apply)
      + swap_placement_policy                   = "inherit"
      + tools_upgrade_policy                    = "manual"
      + uuid                                    = (known after apply)
      + vapp_transport                          = (known after apply)
      + vmware_tools_status                     = (known after apply)
      + vmx_path                                = (known after apply)
      + wait_for_guest_ip_timeout               = 0
      + wait_for_guest_net_routable             = true
      + wait_for_guest_net_timeout              = 5

      + disk {
          + attach            = false
          + controller_type   = "scsi"
          + datastore_id      = "<computed>"
          + device_address    = (known after apply)
          + disk_mode         = "persistent"
          + disk_sharing      = "sharingNone"
          + eagerly_scrub     = false
          + io_limit          = -1
          + io_reservation    = 0
          + io_share_count    = 0
          + io_share_level    = "normal"
          + keep_on_remove    = false
          + key               = 0
          + label             = "disk0"
          + path              = (known after apply)
          + size              = 20
          + storage_policy_id = (known after apply)
          + thin_provisioned  = true
          + unit_number       = 0
          + uuid              = (known after apply)
          + write_through     = false
        }

      + network_interface {
          + adapter_type          = "vmxnet3"
          + bandwidth_limit       = -1
          + bandwidth_reservation = 0
          + bandwidth_share_count = (known after apply)
          + bandwidth_share_level = "normal"
          + device_address        = (known after apply)
          + key                   = (known after apply)
          + mac_address           = (known after apply)
          + network_id            = "network-18"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────

Saved the plan to: planOutput

To perform exactly these actions, run the following command to apply:
    terraform apply "planOutput"
```

Last step the user can execute the action(s) proposed from previous step `terraform plan`. Sample:

```shell
$ terraform apply planOutput
module.vm-template.vsphere_virtual_machine.virtual_machine: Creating...
module.vm-template.vsphere_virtual_machine.virtual_machine: Still creating... [10s elapsed]
module.vm-template.vsphere_virtual_machine.virtual_machine: Still creating... [20s elapsed]
module.vm-template.vsphere_virtual_machine.virtual_machine: Still creating... [30s elapsed]
module.vm-template.vsphere_virtual_machine.virtual_machine: Still creating... [40s elapsed]
module.vm-template.vsphere_virtual_machine.virtual_machine: Still creating... [50s elapsed]
module.vm-template.vsphere_virtual_machine.virtual_machine: Still creating... [1m0s elapsed]
module.vm-template.vsphere_virtual_machine.virtual_machine: Still creating... [1m10s elapsed]
module.vm-template.vsphere_virtual_machine.virtual_machine: Still creating... [1m20s elapsed]
module.vm-template.vsphere_virtual_machine.virtual_machine: Creation complete after 1m27s [id=42174053-426f-0f8f-6c91-14dc80366d72]
```

If the user decides to destroy the created VMs it easily be applied with terraform as well. Sample of command:

````bash
$ terraform plan -destroy -out=destroyOutput -var-file=tfvars/dev.tfvars
data.vsphere_datacenter.datacenter: Reading...
data.vsphere_datacenter.datacenter: Read complete after 1s [id=datacenter-213]
data.vsphere_network.network: Reading...
data.vsphere_datastore.datastore: Reading...
data.vsphere_compute_cluster.cluster: Reading...
data.vsphere_virtual_machine.template: Reading...
data.vsphere_datastore.datastore: Read complete after 0s [id=datastore-223]
data.vsphere_network.network: Read complete after 0s [id=network-224]
data.vsphere_compute_cluster.cluster: Read complete after 0s [id=domain-c260]
data.vsphere_virtual_machine.template: Read complete after 1s [id=4217c09b-6f6f-90bd-9ab1-f4fbcc19e70c]
module.vm-template.vsphere_virtual_machine.virtual_machine: Refreshing state... [id=42174053-426f-0f8f-6c91-14dc80366d72]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # module.vm-template.vsphere_virtual_machine.virtual_machine will be destroyed
  - resource "vsphere_virtual_machine" "virtual_machine" {
      - boot_delay                              = 0 -> null
      - boot_retry_delay                        = 10000 -> null
      - boot_retry_enabled                      = false -> null
      - change_version                          = "2023-03-06T15:29:18.847818Z" -> null
      - cpu_hot_add_enabled                     = false -> null
      - cpu_hot_remove_enabled                  = false -> null
      - cpu_limit                               = -1 -> null
      - cpu_performance_counters_enabled        = false -> null
      - cpu_reservation                         = 0 -> null
      - cpu_share_count                         = 1000 -> null
      - cpu_share_level                         = "normal" -> null
      - custom_attributes                       = {} -> null
      - datastore_id                            = "datastore-223" -> null
      - efi_secure_boot_enabled                 = false -> null
      - enable_disk_uuid                        = false -> null
      - enable_logging                          = false -> null
      - ept_rvi_mode                            = "automatic" -> null
      - extra_config                            = {} -> null
      - extra_config_reboot_required            = true -> null
      - firmware                                = "bios" -> null
      - force_power_off                         = true -> null
      - guest_id                                = "ubuntu64Guest" -> null
      - guest_ip_addresses                      = [] -> null
      - hardware_version                        = 19 -> null
      - host_system_id                          = "host-220" -> null
      - hv_mode                                 = "hvAuto" -> null
      - id                                      = "42174053-426f-0f8f-6c91-14dc80366d72" -> null
      - ide_controller_count                    = 2 -> null
      - latency_sensitivity                     = "normal" -> null
      - memory                                  = 1024 -> null
      - memory_hot_add_enabled                  = false -> null
      - memory_limit                            = -1 -> null
      - memory_reservation                      = 0 -> null
      - memory_share_count                      = 10240 -> null
      - memory_share_level                      = "normal" -> null
      - migrate_wait_timeout                    = 30 -> null
      - moid                                    = "vm-2535" -> null
      - name                                    = "ubuntu-server-template-demo" -> null
      - nested_hv_enabled                       = false -> null
      - num_cores_per_socket                    = 1 -> null
      - num_cpus                                = 1 -> null
      - pci_device_id                           = [] -> null
      - power_state                             = "off" -> null
      - poweron_timeout                         = 300 -> null
      - reboot_required                         = false -> null
      - resource_pool_id                        = "resgroup-261" -> null
      - run_tools_scripts_after_power_on        = true -> null
      - run_tools_scripts_after_resume          = true -> null
      - run_tools_scripts_before_guest_reboot   = false -> null
      - run_tools_scripts_before_guest_shutdown = true -> null
      - run_tools_scripts_before_guest_standby  = true -> null
      - sata_controller_count                   = 0 -> null
      - scsi_bus_sharing                        = "noSharing" -> null
      - scsi_controller_count                   = 1 -> null
      - scsi_type                               = "lsilogic" -> null
      - shutdown_wait_timeout                   = 3 -> null
      - swap_placement_policy                   = "inherit" -> null
      - sync_time_with_host                     = true -> null
      - sync_time_with_host_periodically        = false -> null
      - tags                                    = [] -> null
      - tools_upgrade_policy                    = "manual" -> null
      - uuid                                    = "42174053-426f-0f8f-6c91-14dc80366d72" -> null
      - vapp_transport                          = [] -> null
      - vbs_enabled                             = false -> null
      - vmware_tools_status                     = "guestToolsNotRunning" -> null
      - vmx_path                                = "ubuntu-server-template-demo_1/ubuntu-server-template-demo.vmx" -> null
      - vvtd_enabled                            = false -> null
      - wait_for_guest_ip_timeout               = 0 -> null
      - wait_for_guest_net_routable             = true -> null
      - wait_for_guest_net_timeout              = 0 -> null

      - clone {
          - linked_clone    = false -> null
          - ovf_network_map = {} -> null
          - ovf_storage_map = {} -> null
          - template_uuid   = "4217c09b-6f6f-90bd-9ab1-f4fbcc19e70c" -> null
          - timeout         = 30 -> null

          - customize {
              - dns_server_list = [] -> null
              - dns_suffix_list = [] -> null
              - timeout         = 10 -> null

              - linux_options {
                  - domain       = "MYDOMAIN.com" -> null
                  - host_name    = "foo-demo-host" -> null
                  - hw_clock_utc = true -> null
                }

              - network_interface {}
            }
        }

      - disk {
          - attach           = false -> null
          - controller_type  = "scsi" -> null
          - datastore_id     = "datastore-223" -> null
          - device_address   = "scsi:0:0" -> null
          - disk_mode        = "persistent" -> null
          - disk_sharing     = "sharingNone" -> null
          - eagerly_scrub    = false -> null
          - io_limit         = -1 -> null
          - io_reservation   = 0 -> null
          - io_share_count   = 1000 -> null
          - io_share_level   = "normal" -> null
          - keep_on_remove   = false -> null
          - key              = 2000 -> null
          - label            = "disk0" -> null
          - path             = "ubuntu-server-template-demo_1/ubuntu-server-template-demo.vmdk" -> null
          - size             = 16 -> null
          - thin_provisioned = false -> null
          - unit_number      = 0 -> null
          - uuid             = "6000C299-5ddd-0054-f459-634e50778c1a" -> null
          - write_through    = false -> null
        }

      - network_interface {
          - adapter_type          = "vmxnet3" -> null
          - bandwidth_limit       = -1 -> null
          - bandwidth_reservation = 0 -> null
          - bandwidth_share_count = 50 -> null
          - bandwidth_share_level = "normal" -> null
          - device_address        = "pci:0:7" -> null
          - key                   = 4000 -> null
          - mac_address           = "00:50:56:97:78:15" -> null
          - network_id            = "network-224" -> null
          - use_static_mac        = false -> null
        }
    }

Plan: 0 to add, 0 to change, 1 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Saved the plan to: destroyOutput

To perform exactly these actions, run the following command to apply:
    terraform apply "destroyOutput"
````

Last step apply the command (after reviewing the destroyed resources):

````bash
$ terraform apply destroyOutput
module.vm-template.vsphere_virtual_machine.virtual_machine: Destroying... [id=42174053-426f-0f8f-6c91-14dc80366d72]
module.vm-template.vsphere_virtual_machine.virtual_machine: Destruction complete after 0s

Apply complete! Resources: 0 added, 0 changed, 1 destroyed.
````

Due a variety of parameters e.g. (network traffic, VSphere resources etc) the time can vary. The numbers provided above on all samples are just demos.

