# Setup the infrastructure components required to create the environment
provider "azurerm" {
  features {}
}

# Create a resource group to contain all the objects
resource "azurerm_resource_group" "rg" {
  name     = "${var.azure_rg_name}-${join("", split(":", timestamp()))}" #Removing the colons since Azure doesn't allow them.
  location = var.azure_region

  tags = {
    X-Dept        = var.tag_dept
    X-Customer    = var.tag_customer
    X-Project     = var.tag_project
    X-Application = var.tag_application
    X-Contact     = var.tag_contact
    X-TTL         = var.tag_ttl
  }
}

# Create the virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.azure_rg_name}_Network"
  address_space       = ["10.1.0.0/16"]
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    X-Dept        = var.tag_dept
    X-Customer    = var.tag_customer
    X-Project     = var.tag_project
    X-Application = var.tag_application
    X-Contact     = var.tag_contact
    X-TTL         = var.tag_ttl
  }
}

# Create the individual subnet for the servers
resource "azurerm_subnet" "subnet" {
  name                 = "${var.azure_rg_name}_Subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.1.1.0/24"

}

# create the network security group to allow inbound access to the servers
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.azure_rg_name}_nsg"
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.rg.name
  
  # create a rule to allow RDP inbound to all nodes in the network
  security_rule {
    name                       = "Allow_RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.source_address_prefix
    destination_address_prefix = "*"
  }
  
  # create a rule to allow WinRM inbound to all nodes in the network. Note the priority. All rules but have a unique priority
  security_rule {
    name                       = "Allow_WinRM"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = var.source_address_prefix
    destination_address_prefix = "*"
  }

  tags = {
    X-Dept        = var.tag_dept
    X-Customer    = var.tag_customer
    X-Project     = var.tag_project
    X-Application = var.tag_application
    X-Contact     = var.tag_contact
    X-TTL         = var.tag_ttl
  }
}

# Associate NSG with Subnet so systems are protected
resource "azurerm_subnet_network_security_group_association" "sg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}