resource "azuread_application" "aks_app" {
  name                       = "${var.ad_app_name}"
  homepage                   = "${var.ad_app_home_page}"
  reply_urls                 = ["${var.ad_app_reply_urls}"]
  available_to_other_tenants = "${var.available_to_other_tenants}"
  oauth2_allow_implicit_flow = "${var.oauth2_allow_implicit_flow}"
  type                       = "${var.ad_app_type}"
}

// resource "azuread_application_password" "aks_app_pw" {
//   application_object_id = "${azuread_application.aks_app.id}"
//   value          = "!${random_id.random_id.hex}@${random_string.password.result}!${random_id.random_id.hex}@"
//   end_date       = "2021-01-01T01:02:03Z"
// }

resource "azuread_service_principal" "aks_sp" {
  application_id = "${azuread_application.aks_app.application_id}"
}

resource "azuread_service_principal_password" "aks_sp_pwd" {
  service_principal_id = "${azuread_service_principal.aks_sp.id}"
  value                = "${var.service_principal_pwd}"
  end_date             = "${var.service_principal_end_date}"
}