data "ct_config" "node" {
  strict       = true
  pretty_print = false
  content = templatefile("${path.module}/config/config.yaml", {
    ssh_keys      = jsonencode(var.ssh_keys)
    hostname      = var.node_name
    update_group  = var.flatcar_update_group
    update_server = var.flatcar_update_server
    dns_servers   = join(" ", var.dns_servers)
  })
  platform = "openstack-metadata"
  snippets = var.clc_snippets
}

resource "openstack_compute_instance_v2" "node" {
  name            = var.node_name
  region          = var.region
  image_name      = var.image_name
  flavor_name     = var.flavor
  key_pair        = var.ssh_key_name
  user_data       = data.ct_config.node.rendered
  security_groups = var.security_groups
  tags            = var.tags

  dynamic "network" {
    for_each = var.networks
    content {
      name = network.value.name
    }
  }
}
