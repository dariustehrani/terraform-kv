variable "project_name" {
  description = "Define a project name that everyone can relate to"
  type        = "string"
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
}

variable "location" {
  description = "The location where resources will be created"
}

variable "tags" {
  description = "A map of the tags to use for the resources that are deployed"
  type        = "map"
}

variable "devops_sp" {
  description = "sp allowed to access the kv"
  type = "string"
}
