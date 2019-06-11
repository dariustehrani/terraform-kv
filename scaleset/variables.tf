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

variable "subnet_id" {
  description = "subnet id to be used"
  type        = "string"
}

variable "vm_sku" {
  description = "set the VM size"
  type        = "string"
  default     = "Standard_B2s"
}

variable "capacity" {
  description = "the count of VMs to be provisioned"
  type        = "string"
  default     = "2"
}

variable "admin_user" {
  description = "please define the name of the local admin"
  type        = "string"
}

variable "path_to_ssh_pubkey" {
  description = "please point to a local SSH Pubkey that shall be allowed for login on the scaleset. Notice that you need to combine this with the admin user you defined previously"
  type        = "string"
}

variable "application_port" {
  description = "ports that are exposed by the LB. also relevant for health checks"
  type        = "string"
  default     = "80"
}
