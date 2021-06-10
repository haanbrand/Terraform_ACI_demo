
resource "aci_epg_to_domain" "prod_epg_to_dcfwfo_physdom" {
  application_epg_dn    = "${aci_application_epg.epg_prod.id}"
  tdn                   = "${aci_physical_domain.dcfwfo_phydom.id}"
  encap                 = "vlan-2032"
}

resource "aci_vlan_pool" "dcfwfo_vlpool" {
    name            =       "dcfwfo-VLPOOL"
    description     =       "dcfwfo-VLPOOL"
    alloc_mode      =       "static"
}

resource "aci_ranges" "dcfwfo_vlan_pool_range_static" {
    vlan_pool_dn    =       aci_vlan_pool.dcfwfo_vlpool.id
    from            =       "vlan-2031"
    to              =       "vlan-2034"
    alloc_mode      =       "inherit"
    role            =       "external"
}

resource "aci_physical_domain" "dcfwfo_phydom" {
  depends_on = [aci_vlan_pool.dcfwfo_vlpool]
  name  = "dcfwfo-PHYDOM"
  relation_infra_rs_vlan_ns = aci_vlan_pool.dcfwfo_vlpool.id
}

resource "aci_attachable_access_entity_profile" "dcfwfo_aaep" {
  description = "Attached Entity Profile for DCFWFO-AAEP"
  name        = "DCFWFO-AAEP"
  annotation  = "tag_entity"
  name_alias  = "alias_entity"
  relation_infra_rs_dom_p = [aci_physical_domain.dcfwfo_phydom.id]
}

resource "aci_leaf_access_bundle_policy_group" "dcfwfo_intpolg_vpc" {
    name                            = "dcfwfo_intpolg_vpc"
    lag_t                           = "node"
    #relation_infra_rs_cdp_if_pol    = aci_cdp_interface_policy.CDP_Enabled.id
    #relation_infra_rs_lldp_if_pol   = data.aci_lldp_interface_policy.aci_lab_lldp.id
    #relation_infra_rs_mcp_if_pol    = data.aci_miscabling_protocol_interface_policy.aci_lab_mcp.id
    #relation_infra_rs_l2_if_pol     = data.aci_l2_interface_policy.aci_lab_l2global.id
    relation_infra_rs_h_if_pol       = aci_fabric_if_pol.Speed_10G_AUTO_ON.id
    relation_infra_rs_lacp_pol      = aci_lacp_policy.LACP_ACT.id
    relation_infra_rs_att_ent_p     = aci_attachable_access_entity_profile.dcfwfo_aaep.id
}

resource "aci_access_port_selector" "dcfwfo_vpc_port_selector" {
    leaf_interface_profile_dn      = aci_leaf_interface_profile.leaf_201_202_profile.id
    name                           = "port_selector_vpc_E1_4_5"
    access_port_selector_type      = "range"
    relation_infra_rs_acc_base_grp = aci_leaf_access_bundle_policy_group.dcfwfo_intpolg_vpc.id
}

resource "aci_access_port_block" "dcfwfo_vpc_port_block" {
    access_port_selector_dn = aci_access_port_selector.dcfwfo_vpc_port_selector.id
    name                    = "port_block_E1_51"
    from_card               = "1"
    from_port               = "4"
    to_card                 = "1"
    to_port                 = "5"
}
