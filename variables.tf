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

variable "env" {
  type        = string
  description = "[dev/test/prod] identification"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type = string
}

variable "stack_name" {
  type        = string
  description = "Name of the stack responsible for deploying the resource"
}

variable "subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}
