resource "azurerm_virtual_machine_scale_set" "infra" {
  name                = "${var.project_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  upgrade_policy_mode = "Manual"
  depends_on          = ["azurerm_lb.infra"]

  sku {
    name     = "${var.vm_sku}"
    tier     = "Standard"
    capacity = "${var.capacity}"
  }

  storage_profile_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
    lun           = 0
    caching       = "ReadWrite"
    create_option = "Empty"
    disk_size_gb  = 10
  }

  os_profile {
    computer_name_prefix = "${var.project_name}"
    admin_username       = "${var.admin_user}"

    # admin_password       = "${var.admin_password}"
    custom_data = "${data.template_file.custom-data.rendered}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin_user}/.ssh/authorized_keys"
      key_data = "${file("${var.path_to_ssh_pubkey}")}"
    }
  }

  network_profile {
    name    = "${var.project_name}-nic"
    primary = true

    ip_configuration {
      name                                   = "${var.project_name}-ipconfig"
      subnet_id                              = "${var.subnet_id}"
      load_balancer_backend_address_pool_ids = ["${azurerm_lb_backend_address_pool.bpepool.id}"]

      #  load_balancer_inbound_nat_rules_ids    = ["${element(azurerm_lb_nat_pool.natpool.*.id, count.index)}"]
      primary = true
    }
  }

  tags = "${var.tags}"
}
