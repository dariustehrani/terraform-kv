# Public IP
resource "random_string" "fqdn" {
  length  = 6
  special = false
  upper   = false
  number  = false
}

resource "azurerm_public_ip" "infra" {
  name                = "${var.project_name}-public-ip"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  allocation_method   = "Static"
  domain_name_label   = "${random_string.fqdn.result}"
  tags                = "${var.tags}"
}

# Load-Balancer
resource "azurerm_lb" "infra" {
  name                = "infra-lb"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = "${azurerm_public_ip.infra.id}"
  }

  tags = "${var.tags}"
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.infra.id}"
  name                = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "infra" {
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.infra.id}"
  name                = "probe-${var.application_port}"
  port                = "${var.application_port}"
}

resource "azurerm_lb_rule" "lbrule" {
  resource_group_name            = "${var.resource_group_name}"
  loadbalancer_id                = "${azurerm_lb.infra.id}"
  name                           = "http"
  protocol                       = "Tcp"
  frontend_port                  = "${var.application_port}"
  backend_port                   = "${var.application_port}"
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.bpepool.id}"
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = "${azurerm_lb_probe.infra.id}"
}
