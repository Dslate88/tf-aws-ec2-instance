# general
variable "ami" {
  type = string
}

variable "bastion_name" {
  type    = string
  default = "bastion_host"
}

variable "disable_api_termination" {
  type        = bool
  description = "true requires console termination"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type = string
}

variable "stack_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}
