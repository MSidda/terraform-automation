
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "${var.cluster_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  dns_prefix          = "${var.aks_dns_prefix}"
  kubernetes_version = "${var.kubernetes_verrsion}"

  linux_profile {
        admin_username = "${var.aks_node_user_name}"

        ssh_key {
            key_data = "${file(var.ssh_public_key)}"
        }
    }

  default_node_pool {
    name       = "${var.aks_node_pool_name}"
    node_count = "${var.aks_node_count}"
    vm_size    = "${var.aks_node_size}"
    enable_auto_scaling = "${var.enable_aks_auto_scale}"
    max_count = "${var.node_max_count}"
    min_count = "${var.node_min_count}"
  }


  service_principal {
    client_id     = "${azuread_service_principal.aks_sp.application_id}"
    client_secret = "${azuread_service_principal_password.aks_sp_pwd.value}"
  }

  role_based_access_control {
    enabled = "${var.aks_rbac}"
  }

  tags = {
    Environment = "Production"
  }
}



