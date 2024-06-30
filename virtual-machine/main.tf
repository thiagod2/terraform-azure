# Resource Group
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "velozient-azure-resource-RG"
}

# Create virtual network
resource "azurerm_virtual_network" "my_terraform_network" {
  name                = "velozient-azure-resource-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet
resource "azurerm_subnet" "my_terraform_subnet" {
  name                 = "velozient-azure-resource-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my_terraform_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create public IP for Load Balancer
resource "azurerm_public_ip" "lb_public_ip" {
  name                = "velozient-azure-resource-lb-PublicIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create Load Balancer
resource "azurerm_lb" "my_terraform_lb" {
  name                = "velozient-azure-resource-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "velozient-azure-resource-frontend"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

# Create Load Balancer Backend Address Pool
resource "azurerm_lb_backend_address_pool" "my_terraform_bap" {
  name            = "velozient-azure-resource-bap"
  loadbalancer_id = azurerm_lb.my_terraform_lb.id
}

# Create Load Balancer Probe for HTTP
resource "azurerm_lb_probe" "my_terraform_probe_http" {
  name                = "velozient-azure-resource-probe-http"
  resource_group_name = azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.my_terraform_lb.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
}


# Create Load Balancer Rule for HTTP
resource "azurerm_lb_rule" "my_terraform_lb_rule_http" {
  name                           = "velozient-azure-resource-lb-rule-http"
  resource_group_name            = azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.my_terraform_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "velozient-azure-resource-frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.my_terraform_bap.id]
  probe_id                       = azurerm_lb_probe.my_terraform_probe_http.id

}

# Create public IP
resource "azurerm_public_ip" "my_terraform_public_ip" {
  count               = 2
  name                = "velozient-azure-resource-PublicIP-${count.index + 1}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

# Create Network Security Group and rules
resource "azurerm_network_security_group" "my_terraform_nsg" {
  name                = "velozient-azure-resource-NetworkSecurityGroup"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "my_terraform_nic" {
  count               = 2
  name                = "velozient-azure-resource-myNIC-${count.index + 1}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "velozient-azure-resource-nic-configuration"
    subnet_id                     = azurerm_subnet.my_terraform_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_terraform_public_ip[count.index].id
  }
}

resource "azurerm_network_interface_security_group_association" "my_nsg_assoc" {
  count                     = 2
  network_interface_id      = azurerm_network_interface.my_terraform_nic[count.index].id
  network_security_group_id = azurerm_network_security_group.my_terraform_nsg.id
}

# Create (and display) an SSH key
resource "tls_private_key" "secureadmin_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create virtual machines
resource "azurerm_linux_virtual_machine" "my_terraform_vm" {
  count                 = 2
  name                  = "velozient-azure-resource-VM-${count.index + 1}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.my_terraform_nic[count.index].id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "velozient-azure-resource-OsDisk-${count.index + 1}"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = "velozient-azure-vm"
  admin_username                  = "secureadmin"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "secureadmin"
    public_key = tls_private_key.secureadmin_ssh.public_key_openssh
  }

  provisioner "remote-exec" {
    inline = [
        "sudo apt-get -y update",
        "sudo apt-get -y install nginx",
        "sudo service nginx start"
    ]
    
  }

    connection {
      type        = "ssh"
      user        = "secureadmin"
      private_key = tls_private_key.secureadmin_ssh.private_key_pem
      host        = self.public_ip_address
    }
  
}
