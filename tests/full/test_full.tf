module "main" {
  source                       = "../.."
  description                  = "${var.name} Switch Control Policy."
  ethernet_switching_mode      = "end-host"
  fc_switching_mode            = "end-host"
  mac_address_table_aging      = "Default"
  mac_aging_time               = 14500
  name                         = var.name
  organization                 = "terratest"
  udld_message_interval        = 15
  udld_recovery_action         = "none"
  vlan_port_count_optimization = false
}
