output "resource_group_name" {
  value = ["${module.resource_group.resource_group_name}"]
}

output "acr_login_server" {
    value = ["${module.acr.acr_login_server}"]
}

output "acr_admin_username" {
    value = ["${module.acr.acr_admin_username}"]
}

output "acr_admin_password" {
    value = ["${module.acr.acr_admin_password}"]
}

output "key_vault_uri" {
    value = "${module.key_vault.vault_uri}"
}