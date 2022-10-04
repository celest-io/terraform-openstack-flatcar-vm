# Terraform Flatcar provisioning on Openstack VM

[![GitHub Release](https://img.shields.io/github/release/celest-io/terraform-openstack-flatcar-vm.svg?style=flat)]()

A terraform module that will provision a Flatcar VM on Openstack

## Usage

```terraform
locals {
  ovh_uk_dc = "UK1"
}

resource "openstack_compute_keypair_v2" "provisioning" {
  name       = "k8s-provisioning"
  public_key = local.provisioning_key
  region     = local.ovh_uk_dc
}

data "openstack_networking_network_v2" "ext_network" {
  region   = local.ovh_uk_dc
  name     = "Ext-Net"
}

resource "openstack_networking_secgroup_v2" "k8s_workers" {
  region      = local.ovh_uk_dc
  name        = "k8s-workers"
  description = "Firewall group for k8s workers"
}

resource "openstack_networking_secgroup_rule_v2" "gateway_ssh" {
  region            = local.ovh_uk_dc
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.k8s_workers.id
  description       = "Allow SSH to all nodes globally."
}

module "k8s_worker_1" {
  source    = "celest-io/flatcar-vm/openstack"
  node_name = "k8s-worker-1"
  region    = local.ovh_uk_dc
  networks  = [
    {
      name = data.openstack_networking_network_v2.ext_network.name
    },
  ]

  ssh_key_name    = openstack_compute_keypair_v2.provisioning.name
  ssh_keys        = [local.provisioning_key]
  flavor          = "d2-8"
  security_groups = [openstack_networking_secgroup_v2.k8s_workers.name]
  tags            = ["cluster:k8s"]
  image_name      = "flatcar-stable"
}
```
