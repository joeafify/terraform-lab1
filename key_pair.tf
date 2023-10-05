resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "tf-key-pair" {
  key_name   = "${var.server}-tf-key-pair"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "local_file" "tf-key" {
  content         = tls_private_key.rsa.private_key_pem
  filename        = ".keys/${var.server}-tf-key-pair"
  file_permission = "0400"
}