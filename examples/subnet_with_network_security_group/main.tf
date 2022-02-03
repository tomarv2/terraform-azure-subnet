provider "azurerm" {
  features {}
}

module "network_security_group" {
  source = "git@github.com:tomarv2/terraform-azure-network-security-group.git"

  resource_group_name = "demo-resource_group"
  location            = "westus2"
  source_address      = "10.2.0.0/18"
  dest_port           = ["80", "22"]
  # ---------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

module "subnet" {
  source = "../../"

  virtual_network_name = "demo-vnet"
  resource_group_name = "demo-resource_group"
  # ---------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

resource "azurerm_subnet_network_security_group_association" "subnet_association" {
  subnet_id                 = module.subnet.subnet_id
  network_security_group_id = module.network_security_group.network_security_group_id
}
