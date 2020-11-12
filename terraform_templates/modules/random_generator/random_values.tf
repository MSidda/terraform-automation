resource "random_id" "random_id" {
  byte_length = 2
}

resource "random_string" "password" {
  length  = 8
  special = true
}