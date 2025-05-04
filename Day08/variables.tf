variable "environment" {
  type = string
  description = "The env type."
  default = "staging"
  
}

variable "allowed_location" {
  type = list(string)
  description = "The location/region where the resources will be created."
  default =  [ "West Europe", "North Europe" , "East US" ]
  
}
variable "storage_disk" {
    type = number
    description = "the storage disk size of os"
    default = 80
  
}

variable "is_delete" {
  type = bool
  description = "the default behavior to os disk upon vm termination"
  default = true
}

variable "resource_tags" {
  type = map(string)
  description = "the tags to be applied to the resources"
  default = {
    "environment" = "staging"
    "managed_by" = "devops"
    "department" = "devops"
  
}
}
# Tuple type
variable "network_config" {
  type        = tuple([string, string, number])
  description = "Network configuration (VNET address, subnet address, subnet mask)"
  default     = ["10.0.0.0/16", "10.0.2.0", 24]
}
variable "allowed_vm_sizes" {
  type        = list(string)
  description = "Allowed VM sizes"
  default     = ["Standard_DS1_v2", "Standard_DS2_v2", "Standard_DS3_v2"]
}

variable "storage_account_name" {
  type        = set(string)
  description = "The name of the storage account"
  default     = ["techrajeev101","techrajeev102","techrajeev103"]
  
}