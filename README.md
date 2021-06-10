# Terraform and Cisco ACI demo
Purpose of this is to bring up an ACI Fabric using Terraform and IaC

**Terraform documentation:**
 - https://registry.terraform.io/providers/CiscoDevNet/aci/latest

**NOTE:**

Because we make use of the Cisco sandbox ACI environment we can only simulate adding devices (Spines and Leafs) to the fabric.
Please use this environment with due respect for the provider as well as other users on the system. That goes a long way...respect...just saying ;-)

So if you have your own ACI fabric to play on please change the URL and access details accordingly....

**Outstanding:**
- L3Outs = 0% Complete

Done:
- Bare metal connections - Done
- EPG's - Done
- BD's - Done
- VRFS - Done
- Tenant - Done

Profiles:
- to be updated

Fabric Policies:
- LACP_ACT
- LACP_OFF
- LACP_PASV
- CDP_Enabled
- CDP_Disabled
- Speed_100G_AUTO_OFF
- Speed_10G_AUTO_OFF
- Speed_100G_AUTO_ON
- Speed_10G_AUTO_ON
- Speed_25G_AUTO_ON
- Speed_25G_AUTO_OFF
- Speed_40G_AUTO_ON
- Speed_40G_AUTO_OFF
- LLDP_Enabled
- LLDP_Disabled
- MCP_Enabled

Physical Domains |	VLAN POOL | AAEP
------------|----------------|---------------
server01_phydom	| server01-VLPOOL | Servers-aaep
????	| ????-VLPOOL | ???-aaep
