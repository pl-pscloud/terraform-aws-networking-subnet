variable "pscloud_env" {}
variable "pscloud_company" {}
variable "pscloud_project" { default = "Default"} //tag Project
variable "pscloud_type" { default = "private"}  //for tag (private or public)

variable "pscloud_vpc_id" {}

variable "pscloud_subnets_list" {
  type = map(object({
    az              = string
    cidr_block      = string
  }))
  default = {}
}

variable "pscloud_routes_list" {
  type = map(object({
    gateway_id  = string
    cidr_block          = string
  }))
  default = {}
}

variable "pscloud_routes_by_nat_list" {
  type = map(object({
    nat_gateway_id  = string
    cidr_block          = string
  }))
  default = {}
}

variable "pscloud_routes_by_transit_gateway_list" {
  type = map(object({
    transit_gateway_id  = string
    cidr_block          = string
  }))
  default = {}
}
