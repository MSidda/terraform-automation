module "random_generator" {
  source = "./modules/random_generator"
}

module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  random_id_hex       = "${module.random_generator.random_id_hex}"
}

module "aks" {
  source = "./modules/aks"
  ad_app_name                = "aks-app-${module.random_generator.random_id_hex}"
  ad_app_home_page           = "https://aks-app-${module.random_generator.random_id_hex}"
  ad_app_reply_urls          = "http://aks-app-${module.random_generator.random_id_hex}"
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
  ad_app_type                = "webapp/api"
  service_principal_pwd      = "!${module.random_generator.random_id_hex}@${module.random_generator.random_string_pwd}!${module.random_generator.random_id_hex}@"
  service_principal_end_date = "${var.service_principal_end_date}"
  cluster_name               = "${var.cluster_name}-${module.random_generator.random_id_hex}"
  resource_group_name        = "${module.resource_group.resource_group_name}"
  location                   = "${var.location}"
  aks_dns_prefix             = "${var.aks_dns_prefix}-${module.random_generator.random_id_hex}"
  aks_node_size              = "${var.aks_node_size}"
  aks_node_count             = "${var.aks_node_count}"
  kubernetes_verrsion        = "${var.kubernetes_verrsion}"
  ssh_public_key             = "${var.ssh_public_key}"
  aks_node_user_name         = "${var.aks_node_user_name}"
  aks_node_pool_name         = "defaultnp"
  aks_node_count             = "${var.aks_node_count}"
  enable_aks_auto_scale      = "${var.enable_aks_auto_scale}"
  node_max_count             = "${var.node_max_count}"
  node_min_count             = "${var.node_min_count}"
  aks_rbac                   = "${var.aks_rbac}"
}

module "acr" {
  source              = "./modules/acr"
  acr_name            = "containerregistry${module.random_generator.random_id_hex}"
  admin_enabled       = true
  resource_group_name = "${module.resource_group.resource_group_name}"
  location            = "${var.location}"
  acr_sku             = "${var.acr_sku}"
}

module "key_vault" {
  source             = "./modules/key_vault"
  name                        = "keyvault-${module.random_generator.random_id_hex}"
  location                    = "${var.location}"
  resource_group_name         = "${module.resource_group.resource_group_name}"
  tenant_id                   = "${var.tenant_id}"
  soft_delete_enabled         = false
  sku_name                    = "${var.key_vault_sku_name}"
}
