resource "vultr_instance" "instance" {
  count            = var.instance-count
  plan             = var.plan
  region           = var.region
  os_id            = var.os_id
  snapshot_id      = var.snapshot_id
  ssh_key_ids      = var.ssh_key_ids
  vpc_ids          = var.vpc_ids
  enable_ipv6      = false
  label            = "${var.name}-${count.index}"
  tags             = [var.name]
  hostname         = "${var.name}-${count.index}"
  ddos_protection  = false
  activation_email = false
  backups          = "disabled"
  script_id        = var.script_id

  lifecycle {
    //noinspection HCLUnknownBlockType
    precondition {
      condition     = (var.os_id == null && var.snapshot_id != null) || (var.os_id != null && var.snapshot_id == null)
      error_message = "EC2 instance must be running."
    }
    //noinspection HCLUnknownBlockType,HILUnresolvedReference
    #    postcondition {
    #      condition     = self.server_status == "ok"
    #      error_message = "EC2 instance must be running."
    #    }
  }
}
