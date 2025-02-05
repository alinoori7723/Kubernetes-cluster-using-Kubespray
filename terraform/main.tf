provider "null" {}

resource "null_resource" "bootstrap_k8s" {
  provisioner "local-exec" {
    command = "bash ../bootstrap.sh"
  }
}
