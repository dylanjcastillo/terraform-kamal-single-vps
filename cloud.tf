resource "hcloud_ssh_key" "ssh_vps_root" {
  name       = "ssh-vps-root"
  public_key = var.ssh_vps_root_key
}

resource "hcloud_server" "vps" {
  name        = "vps"
  image       = var.operating_system
  server_type = var.server_type
  location    = var.region
  labels = {
    "ssh"  = "yes",
    "http" = "yes"
  }

  user_data = data.cloudinit_config.cloud_config_vps.rendered

  ssh_keys = [
    hcloud_ssh_key.ssh_vps_root.id
  ]

  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
}

resource "hcloud_firewall" "allow_ssh" {
  name = "allow-ssh"
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  apply_to {
    label_selector = "ssh=yes"
  }
}

resource "hcloud_firewall" "allow_http_https" {
  name = "allow-http-https"
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  apply_to {
    label_selector = "http=yes"
  }
}

# If these firewalls already exist, you can comment the previous section, and uncomment the following section

# data "hcloud_firewall" "block_all_except_ssh" {
#   name = "allow-ssh"
# }

# data "hcloud_firewall" "allow_http_https" {
#   name = "allow-http-https"
# }

# # Apply the existing firewalls to the server
# resource "hcloud_firewall_attachment" "vps_firewall_ssh" {
#   firewall_id = data.hcloud_firewall.block_all_except_ssh.id
#   server_ids  = [hcloud_server.vps.id]
# }

# resource "hcloud_firewall_attachment" "vps_firewall_http" {
#   firewall_id = data.hcloud_firewall.allow_http_https.id
#   server_ids  = [hcloud_server.vps.id]
# }
