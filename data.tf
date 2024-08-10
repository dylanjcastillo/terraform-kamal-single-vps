data "cloudinit_config" "cloud_config_vps" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = templatefile("${path.module}/cloudinit/base.yml.tpl", { ssh_key = var.ssh_vps_kamal_key })
  }

  part {
    content_type = "text/cloud-config"
    content      = file("${path.module}/cloudinit/vps.yml")
    merge_type   = "list(append)+dict(recurse_array)+str()"
  }
}
