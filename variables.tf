

variable "env" {
 description = "The environment of the AWS infrastructure"
 type        = string
 default     = "dev"
}

variable "key_name" {
  description = "The keypair to use"
  type = string
  default = "ky_keypair"
}

variable "base_cidr_block" {
  description = "The base CIDR block to start with"
  type = string
  default = "10.0.0.0/16"
}
