variable "user" {
  description = "Login information"
  type        = map
  default     = {
    #The below are all using the Cisco sandbox simulated ACI environment. Please take care
    # and be mindfull of other users and the infra as this is a free service and should be respected.
    #There are also better ways to keep usernames and passwords safe - documented in the Terraform world.
    username = "admin"
    password = "ciscopsdt"
    url      = "https://sandboxapicdc.cisco.com"
  }
}



variable "vrf1" {
    type    = string
    default = "ProductionVRF"
}
variable "vrf2" {
    type    = string
    default = "NonProductionVRF"
}

variable "bd1" {
    type    = string
    default = "ProductionBD"
}
variable "bd2" {
    type    = string
    default = "NonProductionBD"
}
variable "bd3" {
    type    = string
    default = "TestProductionBD"
}

variable "subnet1" {
    type    = string
    default = "10.1.1.1/24"
}
variable "subnet2" {
    type    = string
    default = "10.2.1.1/24"
}
variable "subnet3" {
    type    = string
    default = "10.3.1.1/24"
}