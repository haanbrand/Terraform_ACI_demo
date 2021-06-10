#Below to create Leaf pair for VPC connections
resource "aci_leaf_interface_profile" "leaf_101_102_int_profile" {
    name                            = "101_102_Leaf_Int_Profile"
}

resource "aci_leaf_profile" "leaf_101_102_profile" {
    name                         = "leaf_101_102_profile"
    relation_infra_rs_acc_port_p = [aci_leaf_interface_profile.leaf_101_102_int_profile.id]
}

resource "aci_leaf_selector" "leaf_selector_101_102" {
    leaf_profile_dn         = aci_leaf_profile.leaf_101_102_profile.id
    name                    = "leaf_101_102_selector_vpc"
    switch_association_type = "range"
}

resource "aci_node_block" "vpc_leaf_nodes_block_101_102" {
    switch_association_dn = aci_leaf_selector.leaf_selector_101_102.id
    name                  = "vpc_leaf_nodes_block_101_102"
    from_                 = "101"
    to_                   = "102"
}
#Below to create 2 x single Leaf profiles for single connected stuff - one for leaf 101 and one for 102
#--------leaf101
resource "aci_leaf_interface_profile" "leaf_101_int_profile" {
    name                            = "101_Leaf_Int_Profile"
}

resource "aci_leaf_profile" "leaf_101_profile" {
    name                         = "leaf_101_profile"
    relation_infra_rs_acc_port_p = [aci_leaf_interface_profile.leaf_101_int_profile.id]
}

resource "aci_leaf_selector" "leaf_selector_101" {
    leaf_profile_dn         = aci_leaf_profile.leaf_101_profile.id
    name                    = "leaf_101_selector"
    switch_association_type = "range"
}

resource "aci_node_block" "vpc_leaf_nodes_block_101" {
    switch_association_dn = aci_leaf_selector.leaf_selector_101.id
    name                  = "vpc_leaf_nodes_block_101"
    from_                 = "101"
    to_                   = "101"
}
#--------leaf102
resource "aci_leaf_interface_profile" "leaf_102_int_profile" {
    name                            = "102_Leaf_Int_Profile"
}

resource "aci_leaf_profile" "leaf_102_profile" {
    name                         = "leaf_102_profile"
    relation_infra_rs_acc_port_p = [aci_leaf_interface_profile.leaf_102_int_profile.id]
}

resource "aci_leaf_selector" "leaf_selector_102" {
    leaf_profile_dn         = aci_leaf_profile.leaf_102_profile.id
    name                    = "leaf_102_selector"
    switch_association_type = "range"
}

resource "aci_node_block" "vpc_leaf_nodes_block_102" {
    switch_association_dn = aci_leaf_selector.leaf_selector_102.id
    name                  = "vpc_leaf_nodes_block_102"
    from_                 = "102"
    to_                   = "102"
}


#Below to simulate our fictitious Leafs 2201 and 2202
resource "aci_leaf_interface_profile" "leaf_2201_2202_int_profile" {
    name                            = "2201_2202_Leaf_Int_Profile"
}

resource "aci_leaf_profile" "leaf_2201_2202_profile" {
    name                         = "leaf_2201_2202_profile"
    relation_infra_rs_acc_port_p = [aci_leaf_interface_profile.leaf_2201_2202_int_profile.id]
}

resource "aci_leaf_selector" "leaf_selector_2201_2202" {
    leaf_profile_dn         = aci_leaf_profile.leaf_2201_2202_profile.id
    name                    = "leaf_2201_2202_selector_vpc"
    switch_association_type = "range"
}

resource "aci_node_block" "vpc_leaf_nodes_block_2201_2202" {
    switch_association_dn = aci_leaf_selector.leaf_selector_2201_2202.id
    name                  = "vpc_leaf_nodes_block_2201_2202"
    from_                 = "2201"
    to_                   = "2202"
}