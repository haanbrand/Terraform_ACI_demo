
resource "aci_fabric_node_member" "cdc_spine_2101" {
  name = "CDC-ACI-SW-2101"
  serial  = "TEP-1-2101"
  name_alias  = "SPINE-2101"
  node_id  = "2101"
  pod_id  = "1"
  role  = "spine"
}
resource "aci_fabric_node_member" "cdc_spine_2102" {
  name = "CDC-ACI-SW-2102"
  serial  = "TEP-1-2102"
  name_alias  = "SPINE-2102"
  node_id  = "2102"
  pod_id  = "1"
  role  = "spine"
}

resource "aci_fabric_node_member" "cdc_leaf_2201" {
  name = "CDC-ACI-SW-2201"
  serial  = "TEP-1-2201"
  name_alias  = "LEAF-2201"
  node_id  = "2201"
  pod_id  = "1"
  role  = "spine"
}

resource "aci_fabric_node_member" "cdc_leaf_2202" {
  name = "CDC-ACI-SW-2202"
  serial  = "TEP-1-2202"
  name_alias  = "LEAF-2202"
  node_id  = "2202"
  pod_id  = "1"
  role  = "spine"
}

resource "aci_fabric_node_member" "cdc_leaf_2203" {
  name = "CDC-ACI-SW-2203"
  serial  = "TEP-1-2203"
  name_alias  = "LEAF-2203"
  node_id  = "2203"
  pod_id  = "1"
  role  = "spine"
}

resource "aci_fabric_node_member" "cdc_leaf_2204" {
  name = "CDC-ACI-SW-2204"
  serial  = "TEP-1-2204"
  name_alias  = "LEAF-2204"
  node_id  = "2204"
  pod_id  = "1"
  role  = "spine"
}