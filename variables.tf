variable "node_name" {
  type        = string
  description = "Name of the instance."
}

variable "flatcar_update_group" {
  type        = string
  description = "The name to the Flatcar Linux update manager."
  default     = "stable"
}

variable "flatcar_update_server" {
  type        = string
  description = "The URL to the Flatcar Linux update manager."
  default     = "http://public.update.flatcar-linux.net/v1/update/"
}

variable "tags" {
  type        = list(string)
  description = "Tags"
  default     = []
}

variable "clc_snippets" {
  type        = list(string)
  description = "List of Butane Config snippets."
  default     = []
}

variable "flavor" {
  type        = string
  description = "Flavor of the instance."
}

variable "image_name" {
  type        = string
  description = "The name of the Flatcar Linux OpenStack image."
  default     = "flatcar-stable"
}

variable "ssh_key_name" {
  type        = string
  description = "The name of a key pair to assign to the instance."
}

variable "ssh_keys" {
  type        = list(string)
  description = "SSH public keys for user 'core'."
}

variable "security_groups" {
  type        = list(string)
  description = "List of security group names."
}

variable "networks" {
  type = set(object({
    name = string
  }))
  description = "List of network name to attach to the instance."
}

variable "region" {
  type        = string
  description = "OpenStack deployment region."
}

variable "dns_servers" {
  type        = list(string)
  description = "List of the DNS servers to use"
  default     = ["1.1.1.1#cloudflare-dns.com", "1.0.0.1#cloudflare-dns.com"]
}
