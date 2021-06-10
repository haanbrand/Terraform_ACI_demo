variable "user" {
  description = "Login information"
  type        = map
  default     = {
    username = "admin"
    password = "ciscopsdt"
    url      = "https://sandboxapicdc.cisco.com"
  }
}



variable "vrf" {
    type    = string
    default = "DB-PROD-VRF"
}
variable "bd" {
    type    = string
    default = "DB-PROD-BD"
}
variable "subnet1" {
    type    = string
    default = "10.52.100.1/24"
}
variable "subnet2" {
    type    = string
    default = "10.52.101.1/24"
}
variable "subnet3" {
    type    = string
    default = "10.52.102.1/24"
}