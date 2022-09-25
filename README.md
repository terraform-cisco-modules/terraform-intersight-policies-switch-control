<!-- BEGIN_TF_DOCS -->
# Terraform Intersight Policies - Switch Control
Manages Intersight Switch Control Policies

Location in GUI:
`Policies` » `Create Policy` » `Switch Control`

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
$env:TF_VAR_secretkey="<secret-key-file-location>""
```
<!-- END_TF_DOCS -->