variable "pscloud_env" {}
variable "pscloud_company" {}
variable "pscloud_project" { default = "Default"} //tag Project
variable "pscloud_type" { default = "private"}  //for tag (private or public)

variable "pscloud_vpc_id" {}

variable "pscloud_subnets_list" {
  type = list(object({
    az              = string
    cidr_block      = string
  }))
  default = []
}

variable "pscloud_routes_list" {
  type = list(object({
    gateway_id      = string
    cidr_block      = string
  }))
  default = []
}