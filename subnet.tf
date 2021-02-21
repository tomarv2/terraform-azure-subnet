resource "azurerm_subnet" "subnet" {
    name                 = "${var.teamid}-${var.prjid}"
    resource_group_name  = "${var.rg_name}"
    virtual_network_name = "${var.vnet_name}"
    address_prefix       = "${var.address_block}"
}

resource "azurerm_subnet_network_security_group_association" "nsgsubnetconnection" {
  subnet_id                 = "${azurerm_subnet.subnet.id}"
  network_security_group_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.rg_name}/providers/Microsoft.Network/networkSecurityGroups/${var.nsg_name}"
}