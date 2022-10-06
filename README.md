<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/terraform-cisco-modules/terraform-intersight-policies-switch-control/actions/workflows/terratest.yml/badge.svg)](https://github.com/terraform-cisco-modules/terraform-intersight-policies-switch-control/actions/workflows/terratest.yml)
# Terraform Intersight Policies - Switch Control
Manages Intersight Switch Control Policies

Location in GUI:
`Policies` » `Create Policy` » `Switch Control`

## Easy IMM

[*Easy IMM - Comprehensive Example*](https://github.com/terraform-cisco-modules/easy-imm-comprehensive-example) - A comprehensive example for policies, pools, and profiles.

## Example

### main.tf
```hcl
module "switch_control" {
  source  = "terraform-cisco-modules/policies-switch-control/intersight"
  version = ">= 1.0.1"

  description                  = "default Switch Control Policy."
  ethernet_switching_mode      = "end-host"
  fc_switching_mode            = "end-host"
  mac_address_table_aging      = "Default"
  mac_aging_time               = 14500
  name                         = "default"
  organization                 = "default"
  tags                         = []
  udld_message_interval        = 15
  udld_recovery_action         = "none"
  vlan_port_count_optimization = false
}
```

### provider.tf
```hcl
terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">=1.0.32"
    }
  }
  required_version = ">=1.3.0"
}

provider "intersight" {
  apikey    = var.apikey
  endpoint  = var.endpoint
  secretkey = var.secretkey
}
```

### variables.tf
```hcl
variable "apikey" {
  description = "Intersight API Key."
  sensitive   = true
  type        = string
}

variable "endpoint" {
  default     = "https://intersight.com"
  description = "Intersight URL."
  type        = string
}

variable "secretkey" {
  description = "Intersight Secret Key."
  sensitive   = true
  type        = string
}
```

## Environment Variables

### Terraform Cloud/Enterprise - Workspace Variables
- Add variable apikey with value of [your-api-key]
- Add variable secretkey with value of [your-secret-file-content]

### Linux
```bash
export TF_VAR_apikey="<your-api-key>"
export TF_VAR_secretkey=`cat <secret-key-file-location>`
```

### Windows
```bash
$env:TF_VAR_apikey="<your-api-key>"
$env:TF_VAR_secretkey="<secret-key-file-location>"
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.32 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | 1.0.32 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | Intersight URL. | `string` | `"https://intersight.com"` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description for the Policy. | `string` | `""` | no |
| <a name="input_domain_profiles"></a> [domain\_profiles](#input\_domain\_profiles) | Map for Moid based Domain Profile Sources. | `any` | `{}` | no |
| <a name="input_ethernet_switching_mode"></a> [ethernet\_switching\_mode](#input\_ethernet\_switching\_mode) | Enable or Disable Ethernet End Host Switching Mode.<br>  * end-host - In end-host mode, the fabric interconnects appear to the upstream devices as end hosts with multiple links.  In this mode, the switch does not run Spanning Tree Protocol and avoids loops by following a set of rules for traffic forwarding.  In case of ethernet switching mode - Ethernet end-host mode is also known as Ethernet host virtualizer.<br>  * switch - In switch mode, the switch runs Spanning Tree Protocol to avoid loops, and broadcast and multicast packets are handled in the traditional way.This is the traditional switch mode. | `string` | `"end-host"` | no |
| <a name="input_fc_switching_mode"></a> [fc\_switching\_mode](#input\_fc\_switching\_mode) | Enable or Disable FC End Host Switching Mode.<br>  * end-host - In end-host mode, the fabric interconnects appear to the upstream devices as end hosts with multiple links.  In this mode, the switch does not run Spanning Tree Protocol and avoids loops by following a set of rules for traffic forwarding.  In case of ethernet switching mode - Ethernet end-host mode is also known as Ethernet host virtualizer.<br>  * switch - In switch mode, the switch runs Spanning Tree Protocol to avoid loops, and broadcast and multicast packets are handled in the traditional way.This is the traditional switch mode. | `string` | `"end-host"` | no |
| <a name="input_mac_address_table_aging"></a> [mac\_address\_table\_aging](#input\_mac\_address\_table\_aging) | This specifies one of the option to configure the MAC address aging time.<br>* Custom - This option allows the the user to configure the MAC address aging time on the switch. For Switch Model UCS-FI-6454 or higher, the valid range is 120 to 918000 seconds and the switch will set the lower multiple of 5 of the given time.<br>* Default - This option sets the default MAC address aging time to 14500 seconds for End Host mode.<br>* Never - This option disables the MAC address aging process and never allows the MAC address entries to get removed from the table. | `string` | `"Default"` | no |
| <a name="input_mac_aging_time"></a> [mac\_aging\_time](#input\_mac\_aging\_time) | Define the MAC address aging time in seconds.  Range is between 120 to 918000, in multiples of 5, when mac\_aging\_option is set to Custom. | `string` | `14500` | no |
| <a name="input_moids"></a> [moids](#input\_moids) | Flag to Determine if pools and policies should be data sources or if they already defined as a moid. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the Policy. | `string` | `"default"` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Intersight Organization Name to Apply Policy to.  https://intersight.com/an/settings/organizations/. | `string` | `"default"` | no |
| <a name="input_profiles"></a> [profiles](#input\_profiles) | List of UCS Domain Profile Moids to Assign to the Policy. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of Tag Attributes to Assign to the Policy. | `list(map(string))` | `[]` | no |
| <a name="input_udld_message_interval"></a> [udld\_message\_interval](#input\_udld\_message\_interval) | Configures the time between UDLD probe messages on ports that are in advertisement mode and arecurrently determined to be bidirectional.  Valid values are from 7 to 90 seconds. | `number` | `15` | no |
| <a name="input_udld_recovery_action"></a> [udld\_recovery\_action](#input\_udld\_recovery\_action) | UDLD recovery when enabled, attempts to bring an UDLD error-disabled port out of reset.<br>* none - No action is taken when a port has been disabled.<br>* reset - The switch will attempt to bring a UDLD error-disabled port back online. | `string` | `"none"` | no |
| <a name="input_vlan_port_count_optimization"></a> [vlan\_port\_count\_optimization](#input\_vlan\_port\_count\_optimization) | To enable or disable the VLAN port count optimization. | `bool` | `false` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_moid"></a> [moid](#output\_moid) | Switch Control Policy Managed Object ID (moid). |
## Resources

| Name | Type |
|------|------|
| [intersight_fabric_switch_control_policy.switch_control](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/fabric_switch_control_policy) | resource |
| [intersight_fabric_switch_profile.profiles](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_switch_profile) | data source |
| [intersight_organization_organization.org_moid](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |
<!-- END_TF_DOCS -->