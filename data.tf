data "cloudinit_config" "cloud_config_vps" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = file("${path.module}/cloudinit/vps.yml", {ssh_key = var.ssh_vps_kamal_key})
  }
}
