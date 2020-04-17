# Azure Options
variable "azure_region" {
  default     = "centralus" # Use region shortname here as it's interpolated into the URLs
  description = "The location/region where the resources are created."
}

variable "azure_rg_name" {
  default = "lab" # This will get a unique timestamp appended
  description = "Specify the name of the new resource group"
}

variable "source_address_prefix" {
  default = "*"
  description = "Provide an IP or subnet to restrict access. 1.2.3.4 or 1.2.3.0/24"
}


# Shared Options

variable "username" {
  default = "labadmin"
  description = "Admin username for all VMs"
}

variable "password" {
  default = "P@ssw0rd1234!"
  description = "Admin password for all VMs"
}

variable "vm_size" {
  default = "Standard_DS1_v2"
  description = "Specify the VM Size"
}

variable "server_name" {
  default = "win"
  description = "Specify the hostname for the Chef server"
}

# Required tags
variable "tag_customer" {
  description = "Customer name"
}

variable "tag_project" {
  description = "Identify the project"
}

variable "tag_dept" {
  description = "Dept. i.e. Sales/CS/etc."
}

variable "tag_contact" {
  description = "Email address for project owner"
}

variable "tag_application" {
  description = "What app does this run"
}

variable "tag_ttl" {
  default = 4
  description = "Time, in hours, the environment should be allowed to live"
}