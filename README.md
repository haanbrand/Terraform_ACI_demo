# Terraform and Cisco ACI demo
Purpose of this is to bring up an ACI Fabric using Terraform and IaC

**NOTE:**

If the nodes (Leafs and Spines) are already registered to APIC, then please rename the "fabric_init.tf" file to "fabric_init.tf.ignore".

**Outstanding:**
- L3Outs = 0% Complete

Done:
- Bare metal connections - Done
- EPG's - Done
- BD's - Done
- VRFS - Done
- Tenant - Done

Profiles:
- CDC-201_202-LPRO
- CDC-203_204-LPRO

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

Physical Domains|	VLAN POOL
------------|----------------
AZFW-PHYDOM	| AZFW-VLPOOL
AZFW-PHYDOM	| AZFW-VLPOOL
