/* ==== general vars ==== */
variable "region" {
  default = "us-west-2"
}

variable "env" {
  default = "prod"
}

variable "account_number" {
  default = "941964952328"
}

variable "default_tags" {
  default = {
    "terraform"  = "true"
    "type"       = "ci"
    "costcenter" = "5326"
    "workorder"  = "143003146"
  }
}