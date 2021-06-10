resource "aci_leaf_interface_profile" "leaf_201_202_profile" {
    name                            = "CDC-201_202-LPRO"
}

resource "aci_leaf_profile" "leaf_201_202_profile" {
    name                         = "leaf_201_202_profile"
    relation_infra_rs_acc_port_p = [aci_leaf_interface_profile.leaf_201_202_profile.id]
}

resource "aci_leaf_selector" "leaf_selector_201_202" {
    leaf_profile_dn         = aci_leaf_profile.leaf_201_202_profile.id
    name                    = "leaf_201_202_selector_vpc"
    switch_association_type = "range"
}

resource "aci_node_block" "vpc_leaf_nodes_block_201_202" {
    switch_association_dn = aci_leaf_selector.leaf_selector_201_202.id
    name                  = "vpc_leaf_nodes_block_201_202"
    from_                 = "2201"
    to_                   = "2202"
}

resource "aci_leaf_interface_profile" "leaf_203_204_profile" {
    name                            = "CDC-203_204-LPRO"
}

resource "aci_leaf_profile" "leaf_203_204_profile" {
    name                         = "leaf_203_204_profile"
    relation_infra_rs_acc_port_p = [aci_leaf_interface_profile.leaf_203_204_profile.id]
}

resource "aci_leaf_selector" "leaf_selector_203_204" {
    leaf_profile_dn         = aci_leaf_profile.leaf_203_204_profile.id
    name                    = "leaf_203_204_selector_vpc"
    switch_association_type = "range"
}

resource "aci_node_block" "vpc_leaf_nodes_block_203_204" {
    switch_association_dn = aci_leaf_selector.leaf_selector_203_204.id
    name                  = "vpc_leaf_nodes_block_203_204"
    from_                 = "2203"
    to_                   = "2204"
}