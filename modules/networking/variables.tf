variable "resource_group_name" {
  type=string
  description="This defines the name of the resource group"
}

variable "location" {
  type=string
  description="This defines the location of the virtual network"
}

variable "virtual_network_name" {
  type=string
  description="This defines the name of the virtual network"
}

variable "virtual_network_address_space" {
  type=string
  description="This defines the address of the virtual network"
}

variable subnet_names {
    type=set(string)
    description="This defines the subnets within the virtual network"
}

variable "bastion_required" {
  type=bool
  description="This defines whether the bastion service is required"
  default = false
}

variable network-security_group_names {
    type=map(string)
    description="This defines the names of the network security groups"
}

variable "network_security_group_rules" {
  type=list
  description = "This defines the network security group rules"
}