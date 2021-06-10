terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
    }
  }
}

# Configure the provider with your Cisco APIC credentials.
provider "aci" {
  # APIC Username
  username = var.user.username
  # APIC Password
  password = var.user.password
  # APIC URL
  url      = var.user.url
  insecure = true
}

#======================================================Tenant====================================

# Define an ACI Tenant Resource.
resource "aci_tenant" "tenant01" {
    name        = "A01_Tenant"
    description = "This tenant is created by BOFH"
}

#======================================================VRF====================================

# Define an ACI Tenant VRF Resource.
resource "aci_vrf" "vrf_prod" {
    tenant_dn   = aci_tenant.tenant01.id
    description = "Production VRF"
    name        = "DB-PROD-VRF"
    bd_enforced_enable = "no"
}

resource "aci_vrf" "vrf_non_prod" {
    tenant_dn   = aci_tenant.tenant01.id
    description = "Non-Production VRF"
    name        = "DB-NONPROD-VRF"
    bd_enforced_enable = "no"
}

#=================================================Bridge_Domains & Subnets====================================

# Define an ACI Tenant BD Resource.
resource "aci_bridge_domain" "bd_prod" {
    tenant_dn          = aci_tenant.tenant01.id
    relation_fv_rs_ctx = aci_vrf.vrf_prod.id
    description        = "Data Bunker Oracle Production Bridge Domain"
    name               = "DB-PROD-BD"
    arp_flood          = "yes"
    bridge_domain_type          = "regular"
    limit_ip_learn_to_subnets   = "yes"
    ip_learning                 = "yes"
    host_based_routing          = "yes"
}

resource "aci_bridge_domain" "bd_non_prod" {
    tenant_dn          = aci_tenant.tenant01.id
    relation_fv_rs_ctx = aci_vrf.vrf_non_prod.id
    description        = "Data Bunker Oracle Non Production Bridge Domain"
    name               = "DB-NONPROD-BD"
    arp_flood          = "yes"
    bridge_domain_type          = "regular"
    limit_ip_learn_to_subnets   = "yes"
    ip_learning                 = "yes"
    host_based_routing          = "yes"
}

resource "aci_bridge_domain" "bd_repl" {
    tenant_dn          = aci_tenant.tenant01.id
    relation_fv_rs_ctx = aci_vrf.vrf_prod.id
    description        = "Data Bunker Oracle Replication Bridge Domain"
    name               = "DB-REPLICA-BD"
    arp_flood          = "yes"
    bridge_domain_type          = "regular"
    limit_ip_learn_to_subnets   = "yes"
    ip_learning                 = "yes"
    host_based_routing          = "yes"
}

# Define an ACI Tenant BD Subnet Resource.
resource "aci_subnet" "subnet_prod" {
    parent_dn   = aci_bridge_domain.bd_prod.id
    description = "Oracle Production Subnet"
    ip          = "10.52.100.1/24"
    scope       = ["public"]
}

resource "aci_subnet" "subnet_non_prod" {
    parent_dn   = aci_bridge_domain.bd_non_prod.id
    description = "Oracle Non-Production Subnet"
    ip          = "10.52.101.1/24"
    scope       = ["public"]
}

resource "aci_subnet" "subnet_repl" {
    parent_dn   = aci_bridge_domain.bd_repl.id
    description = "Oracle Replication Subnet"
    ip          = "10.52.102.1/24"
    scope       = ["public"]
}

#======================================================Application_Profile====================================

resource "aci_application_profile" "app_01" {
	tenant_dn = aci_tenant.tenant01.id
	name      = "DB-APP-PRO"
    description = "Oracle DB Application"
}

#======================================================EPG====================================

resource "aci_application_epg" "epg_prod" {
	application_profile_dn = aci_application_profile.app_01.id
	name                   = "DB-PROD-EPG"
	relation_fv_rs_bd      = aci_bridge_domain.bd_prod.id
	#relation_fv_rs_dom_att = ["${data.aci_vmm_domain.vds.id}"] 
	#relation_fv_rs_cons    = ["${aci_contract.contract_epg1_epg2.name}"]
    description     = "Data Bunker Oracle Production EPG"
    pc_enf_pref     = "unenforced"
    flood_on_encap  = "disabled"
    pref_gr_memb    = "exclude"
    fwd_ctrl        = "none"
}

resource "aci_application_epg" "epg_non_prod" {
	application_profile_dn = aci_application_profile.app_01.id
	name                   = "DB-NONPROD-EPG"
	relation_fv_rs_bd      = aci_bridge_domain.bd_non_prod.id
	#relation_fv_rs_dom_att = ["${data.aci_vmm_domain.vds.id}"] 
	#relation_fv_rs_prov    = ["${aci_contract.contract_epg1_epg2.name}"]
    description     = "Data Bunker Oracle None Production EPG"
    pc_enf_pref     = "unenforced"
    flood_on_encap  = "disabled"
    pref_gr_memb    = "exclude"
    fwd_ctrl        = "none"
}

resource "aci_application_epg" "epg_repl" {
	application_profile_dn = aci_application_profile.app_01.id
	name                   = "DB-REPLICA-EPG"
	relation_fv_rs_bd      = aci_bridge_domain.bd_repl.id
	#relation_fv_rs_dom_att = ["${data.aci_vmm_domain.vds.id}"] 
	#relation_fv_rs_prov    = ["${aci_contract.contract_epg1_epg2.name}"]
    description     = "Data Bunker Oracle Replication  EPG"
    pc_enf_pref     = "unenforced"
    flood_on_encap  = "disabled"
    pref_gr_memb    = "exclude"
    fwd_ctrl        = "none"
}

# vzAny for VRFs
resource "aci_any" "vz_any_prod_vrf" {
    vrf_dn = aci_vrf.vrf_prod.id
    pref_gr_memb = "enabled"
}
resource "aci_any" "vz_any_nonprod_vrf" {
    vrf_dn = aci_vrf.vrf_non_prod.id
    pref_gr_memb = "enabled"
}

#======================================================VPC Explicit Protection Group====================================

resource "aci_vpc_explicit_protection_group" "cdc_expl_prot_grp_201_202" {
  name                              = "CDC-201_202-VPCG"
  annotation                        = "tag_vpc"
  switch1                           = "201"
  switch2                           = "202"
  vpc_domain_policy                 = "default"
  vpc_explicit_protection_group_id  = "10"
}
resource "aci_vpc_explicit_protection_group" "cdc_expl_prot_grp_203_204" {
  name                              = "CDC-203_204-VPCG"
  annotation                        = "tag_vpc"
  switch1                           = "203"
  switch2                           = "204"
  vpc_domain_policy                 = "default"
  vpc_explicit_protection_group_id  = "20"
}

#=======================================PHYSICAL WORLD=======================================

# Included as separate files *_aaep.tf





