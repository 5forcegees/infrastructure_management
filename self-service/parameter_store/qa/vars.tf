/* ==== general vars ==== */
variable "region" {
  default = "us-west-2"
}

variable "env" {
  default = "qa"
}

variable "account_number" {
  default = "###CENSORED-QA-ACCOUNT-NUMBER###"
}

variable "default_tags" {
  default = {
    "terraform"  = "true"
    "type"       = "ci"
    "costcenter" = "5326"
    "workorder"  = "143003146"
  }
}
