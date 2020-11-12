output "random_id_hex" {
    value = "${random_id.random_id.hex}"
}

output "random_string_pwd" {
    value = "${random_string.password.result}"
}