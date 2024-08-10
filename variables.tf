variable "hetzner_api_key" {
  description = "The Hetzner Cloud API Token"
  type        = string
}

variable "region" {
  type    = string
  default = "nbg1"
}

variable "server_type" {
  type    = string
  default = "cpx11"
}

variable "operating_system" {
  type    = string
  default = "ubuntu-24.04"
}

variable "web_servers" {
  type    = number
  default = 1
}

variable "ssh_vps_root_key" {
  description = "SSH public key for the user root"
  type        = string
}

variable "ssh_vps_kamal_key" {
  description = "SSH public key for the user kamal"
  type        = string
}
