variable"project_name"{
    type = string
    description = "The name of the project"
    default = "Project ALPHA Resourceweeee"

}

variable "default_tags" {
    type = map(string)
    description = "The default tags to assign to all resources"
    default = {
        company = "Company XYZ"
        managed_by = "Team A"
    }
  
}

variable "environment_tags" {
    type = map(string)
    description = "The tags to assign to all resources in this environment"
    default = {
        environment = "Production"
        cost_center = "CC-1234"
    }
  
}

variable "storage_account_name" {
    type = string
    description = "The name of the storage account"
    default = "techrajeev "
  
}

variable "allowed_ports"{
    type = string
    description = "The security code for the storage account"
    default = "80-90-100"

}

variable "environment" {
  type = string
    description = "The environment to deploy to"
    default = "dev"
    validation {
        condition = contains(["dev", "stagging", "production"], var.environment)
        error_message = "Environment must be either Production or Development"
    }
}

variable "vm_sizes" {
    type = map(string)
    description = "The sizes of the virtual machines to deploy"
    default = {
        dev = "Standard_A1"
        stagging = "Standard_A2"
        production = "Standard_A3"
    }
}

variable "vm_size" {
    type = string
    description = "The sizes of the virtual machines to deploy"
    default = "standard_A1"
    validation {
        condition = length(var.vm_size) >= 2 && length(var.vm_size) <= 20
        error_message = "vm_size should be between 2 and 20 characters"
    }
    validation {
        condition = strcontains(lower(var.vm_size), "standard")
        error_message = "VM size should contain name standard"
    }
  
}
variable "backup_name" {
    default = "test_backup"
    type = string
    validation {
      
      condition = ends_with(var.backup_name, "-backup")
      error_message = "value should end with backup"
    }
  
}

variable "credentials" {
    type =string
    default = "xyu233"
    description = "The credentials to use for the virtual machine"
    sensitive = true
}