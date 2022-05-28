terraform {
  required_providers {
    ct = {
      source  = "poseidon/ct"
      version = "~> 0.10"
    }
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.47"
    }
  }
  required_version = ">= 1.0"
}
