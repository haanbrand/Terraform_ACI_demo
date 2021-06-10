#========================================COMMON POLICIES PROFILES====================================


resource "aci_lacp_policy" "LACP_ACT" {
  description = "LACP_ACT"
  name        = "LACP_ACT"
  annotation  = "tag_lacp"
  ctrl        = ["susp-individual", "load-defer", "graceful-conv"]
  max_links   = "16"
  min_links   = "1"
  mode        = "active"
  name_alias  = "alias_lacp"
}
resource "aci_lacp_policy" "LACP_OFF" {
  description = "LACP_OFF"
  name        = "LACP_OFF"
  annotation  = "tag_lacp"
  ctrl        = ["susp-individual", "load-defer", "graceful-conv"]
  max_links   = "16"
  min_links   = "1"
  mode        = "off"
  name_alias  = "alias_lacp"
}
resource "aci_lacp_policy" "LACP_PASV" {
  description = "LACP_PASV"
  name        = "LACP_PASV"
  annotation  = "tag_lacp"
  ctrl        = ["susp-individual", "load-defer", "graceful-conv"]
  max_links   = "16"
  min_links   = "1"
  mode        = "passive"
  name_alias  = "alias_lacp"
}

resource "aci_cdp_interface_policy" "CDP_Enabled" {
  name        = "CDP_Enabled"
  admin_st    = "enabled"
  annotation  = "tag_cdp"
  name_alias  = "alias_cdp_on"
}
resource "aci_cdp_interface_policy" "CDP_Disabled" {
  name        = "CDP_Disabled"
  admin_st    = "disabled"
  annotation  = "tag_cdp"
  name_alias  = "alias_cdp_off"
}

resource "aci_fabric_if_pol" "Speed_100G_AUTO_OFF" {
  name        = "Speed_100G_AUTO_OFF"
  description = "100Gbps Auto neg off"
  annotation  = "annotation"
  auto_neg    = "off"
  fec_mode    = "inherit"
  name_alias  = "100G"
  speed       = "100G"
}
resource "aci_fabric_if_pol" "Speed_100G_AUTO_ON" {
  name        = "Speed_100G_AUTO_ON"
  description = "100Gbps Auto neg on"
  annotation  = "annotation"
  auto_neg    = "on"
  fec_mode    = "inherit"
  name_alias  = "100G"
  speed       = "100G"
}
resource "aci_fabric_if_pol" "Speed_10G_AUTO_ON" {
  name        = "Speed_10G_AUTO_ON"
  description = "10Gbps Auto neg on"
  annotation  = "annotation"
  auto_neg    = "on"
  fec_mode    = "inherit"
  name_alias  = "10G"
  speed       = "10G"
}
resource "aci_fabric_if_pol" "Speed_10G_AUTO_OFF" {
  name        = "Speed_10G_AUTO_OFF"
  description = "10Gbps Auto neg off"
  annotation  = "annotation"
  auto_neg    = "off"
  fec_mode    = "inherit"
  name_alias  = "10G"
  speed       = "10G"
}
resource "aci_fabric_if_pol" "Speed_25G_AUTO_ON" {
  name        = "Speed_25G_AUTO_ON"
  description = "25Gbps Auto neg on"
  annotation  = "annotation"
  auto_neg    = "on"
  fec_mode    = "inherit"
  name_alias  = "25G"
  speed       = "25G"
}
resource "aci_fabric_if_pol" "Speed_25G_AUTO_OFF" {
  name        = "Speed_25G_AUTO_OFF"
  description = "25Gbps Auto neg off"
  annotation  = "annotation"
  auto_neg    = "off"
  fec_mode    = "inherit"
  name_alias  = "25G"
  speed       = "25G"
}
resource "aci_fabric_if_pol" "Speed_40G_AUTO_ON" {
  name        = "Speed_40G_AUTO_ON"
  description = "40Gbps Auto neg on"
  annotation  = "annotation"
  auto_neg    = "on"
  fec_mode    = "inherit"
  name_alias  = "40G"
  speed       = "40G"
}
resource "aci_fabric_if_pol" "Speed_40G_AUTO_OFF" {
  name        = "Speed_40G_AUTO_OFF"
  description = "40Gbps Auto neg off"
  annotation  = "annotation"
  auto_neg    = "off"
  fec_mode    = "inherit"
  name_alias  = "40G"
  speed       = "40G"
}

resource "aci_lldp_interface_policy" "LLDP_Enabled" {
  description = "LLDP_Enabled"
  name        = "LLDP_Enabled"
  admin_rx_st = "enabled"
  admin_tx_st = "enabled"
  annotation  = "tag_lldp"
  name_alias  = "alias_lldp"
} 

resource "aci_lldp_interface_policy" "LLDP_Disabled" {
  description = "LLDP_Disabled"
  name        = "LLDP_Disabled"
  admin_rx_st = "disabled"
  admin_tx_st = "disabled"
  annotation  = "tag_lldp"
  name_alias  = "alias_lldp"
} 

resource "aci_miscabling_protocol_interface_policy" "MCP_Enabled" {
  description = "Miscabling policy - enabled"
  name        = "MCP_Enabled"
  admin_st    = "enabled"
  annotation  = "tag_mcpol"
  name_alias  = "alias_mcpol"
}
