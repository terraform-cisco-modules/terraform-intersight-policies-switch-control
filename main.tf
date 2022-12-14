#____________________________________________________________
#
# Intersight Organization Data Source
# GUI Location: Settings > Settings > Organizations > {Name}
#____________________________________________________________

data "intersight_organization_organization" "org_moid" {
  for_each = {
    for v in [var.organization] : v => v if var.moids == false
  }
  name = each.value
}

#____________________________________________________________
#
# Intersight UCS Domain Profile(s) Data Source
# GUI Location: Profiles > UCS Domain Profiles > {Name}
#____________________________________________________________

data "intersight_fabric_switch_profile" "profiles" {
  for_each = { for v in var.profiles : v => v if var.moids == false }
  name     = each.value
}


#__________________________________________________________________
#
# Intersight Switch Control Policy
# GUI Location: Policies > Create Policy > Switch Control
#__________________________________________________________________

resource "intersight_fabric_switch_control_policy" "switch_control" {
  depends_on = [
    data.intersight_fabric_switch_profile.profiles,
    data.intersight_organization_organization.org_moid
  ]
  description                    = var.description != "" ? var.description : "${var.name} Switch Control Policy."
  ethernet_switching_mode        = var.ethernet_switching_mode
  fc_switching_mode              = var.fc_switching_mode
  name                           = var.name
  vlan_port_optimization_enabled = var.vlan_port_count_optimization
  mac_aging_settings {
    mac_aging_option = var.mac_address_table_aging
    mac_aging_time   = var.mac_address_table_aging == "Custom" ? var.mac_aging_time : null
  }
  organization {
    moid = length(regexall(true, var.moids)
      ) > 0 ? var.organization : data.intersight_organization_organization.org_moid[
      var.organization].results[0
    ].moid
    object_type = "organization.Organization"
  }
  udld_settings {
    message_interval = var.udld_message_interval
    recovery_action  = var.udld_recovery_action
  }
  dynamic "profiles" {
    for_each = { for v in var.profiles : v => v }
    content {
      moid = length(regexall(true, var.moids)) > 0 ? var.domain_profiles[profiles.value
      ].moid : data.intersight_fabric_switch_profile.profiles[profiles.value].results[0].moid
      object_type = "fabric.SwitchProfile"
    }
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
