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
    description = "Production VRF - used to make money"
    name        = var.vrf1
    bd_enforced_enable = "no"
}

resource "aci_vrf" "vrf_non_prod" {
    tenant_dn   = aci_tenant.tenant01.id
    description = "Non-Production VRF used by crazy devs"
    name        = var.vrf2
    bd_enforced_enable = "no"
}

#=================================================Bridge_Domains & Subnets====================================

# Define an ACI Tenant BD Resource.
resource "aci_bridge_domain" "bd_prod" {
    tenant_dn          = aci_tenant.tenant01.id
    relation_fv_rs_ctx = aci_vrf.vrf_prod.id
    description        = "1st Production Bridge Domain"
    name               = var.bd1
    arp_flood          = "yes"
    bridge_domain_type          = "regular"
    limit_ip_learn_to_subnets   = "yes"
    ip_learning                 = "yes"
    host_based_routing          = "yes"
}

resource "aci_bridge_domain" "bd_non_prod" {
    tenant_dn          = aci_tenant.tenant01.id
    relation_fv_rs_ctx = aci_vrf.vrf_non_prod.id
    description        = "Non Production Bridge Domain"
    name               = var.bd2
    arp_flood          = "yes"
    bridge_domain_type          = "regular"
    limit_ip_learn_to_subnets   = "yes"
    ip_learning                 = "yes"
    host_based_routing          = "yes"
}

resource "aci_bridge_domain" "bd_repl" {
    tenant_dn          = aci_tenant.tenant01.id
    relation_fv_rs_ctx = aci_vrf.vrf_prod.id
    description        = "Testing and Replication Bridge Domain - Production"
    name               = var.bd3
    arp_flood          = "yes"
    bridge_domain_type          = "regular"
    limit_ip_learn_to_subnets   = "yes"
    ip_learning                 = "yes"
    host_based_routing          = "yes"
}

# Define an ACI Tenant BD Subnet Resource.
resource "aci_subnet" "subnet_prod" {
    parent_dn   = aci_bridge_domain.bd_prod.id
    description = "Production Subnet"
    ip          = var.subnet1
    scope       = ["public"]
}

resource "aci_subnet" "subnet_non_prod" {
    parent_dn   = aci_bridge_domain.bd_non_prod.id
    description = "Non-Production Subnet"
    ip          = var.subnet2
    scope       = ["public"]
}

resource "aci_subnet" "subnet_repl" {
    parent_dn   = aci_bridge_domain.bd_repl.id
    description = "Replication and Testing Subnet"
    ip          = var.subnet3
    scope       = ["private"]
}

#======================================================Application_Profile====================================

resource "aci_application_profile" "app_01" {
	tenant_dn = aci_tenant.tenant01.id
	name      = "ProdApplication"
    description = "Example Application"
}

#======================================================EPG====================================

resource "aci_application_epg" "prod_access_epg" {
	application_profile_dn = aci_application_profile.app_01.id
	name                   = "Prod_Access_EPG"
	relation_fv_rs_bd      = aci_bridge_domain.bd_prod.id
	#relation_fv_rs_dom_att = ["${data.aci_vmm_domain.vds.id}"] 
	#relation_fv_rs_cons    = ["${aci_contract.contract_epg1_epg2.name}"]
    description     = "Production Frontend EPG - access between world and services"
    pc_enf_pref     = "unenforced"
    flood_on_encap  = "disabled"
    pref_gr_memb    = "exclude"
    fwd_ctrl        = "none"
}

resource "aci_application_epg" "prod_services_epg" {
	application_profile_dn = aci_application_profile.app_01.id
	name                   = "Prod_Services_EPG"
	relation_fv_rs_bd      = aci_bridge_domain.bd_prod.id
	#relation_fv_rs_dom_att = ["${data.aci_vmm_domain.vds.id}"] 
	#relation_fv_rs_cons    = ["${aci_contract.contract_epg1_epg2.name}"]
    description     = "Production Services EPG - Services lives here and accessed from Access EPG"
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
    description     = "Non Production EPG"
    pc_enf_pref     = "unenforced"
    flood_on_encap  = "disabled"
    pref_gr_memb    = "exclude"
    fwd_ctrl        = "none"
}

resource "aci_application_epg" "epg_repl" {
	application_profile_dn = aci_application_profile.app_01.id
	name                   = "Replication_and_Testing_EPG"
	relation_fv_rs_bd      = aci_bridge_domain.bd_repl.id
	#relation_fv_rs_dom_att = ["${data.aci_vmm_domain.vds.id}"] 
	#relation_fv_rs_prov    = ["${aci_contract.contract_epg1_epg2.name}"]
    description     = "Replication and Testing EPG - misc stuff"
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

# resource "aci_vpc_explicit_protection_group" "expl_prot_grp_101_102" {
#   name                              = "101_102-VPCG"
#   annotation                        = "tag_vpc"
#   switch1                           = "101"
#   switch2                           = "102"
#   vpc_domain_policy                 = "default"
#   vpc_explicit_protection_group_id  = "10"
# }


#=======================================PHYSICAL WORLD=======================================

# Included as separate files *_aaep.tf





