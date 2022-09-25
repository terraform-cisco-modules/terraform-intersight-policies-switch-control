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
