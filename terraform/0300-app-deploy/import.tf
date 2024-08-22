data "terraform_remote_state" "compute" {
  backend = "local"

  config = {
    path = "../0200-compute/terraform.tfstate.d/${var.environment}/terraform.tfstate"
  }
}
