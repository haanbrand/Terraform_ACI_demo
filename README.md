# Terraform and Cisco ACI demo
Purpose of this is to bring up an ACI Fabric using Terraform and IaC

**Terraform documentation:**
 - https://registry.terraform.io/providers/CiscoDevNet/aci/latest

**NOTE:**

Because we make use of the Cisco sandbox ACI environment we can only simulate adding devices (Spines and Leafs) to the fabric.
Please use this environment with due respect for the provider as well as other users on the system. That goes a long way...respect...just saying ;-)

So if you have your own ACI fabric to play on please change the URL and access details accordingly....

**Starting out and Structure**

For the ones that are starting out I have created folders with relevant introductory topics.
For a complete (or near to anyways) Fabric plan the 'complete_scenario' folder will have more info.

For a quick start:
- Install Terraform
- get the files (*.tf) into a folder
- run 'terraform init' (This will initialize terraform for this IaC structure)
- run 'terraform plan' (Will show the plan)
- run 'terraform apply' (Will show the plan again and ask for confirmation before applying)

*Note - when testing this on the Cisco ACI Sandbox environment please use 'terraform apply -parallelism=1'

**Outstanding:**
- L3Outs: Something to come soon

Done:
- Bare metal connections - Done
- EPG's - Done
- BD's - Done
- VRFS - Done
- Tenant - Done
- Misc Fabric Policies - Done

**Specifics:**
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
