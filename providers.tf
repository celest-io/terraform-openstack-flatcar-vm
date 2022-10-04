terraform {
  required_providers {
    ct = {
      source  = "poseidon/ct"
      version = "~> 0.11"
    }
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.48"
    }
  }
  required_version = ">= 1.0"
}
