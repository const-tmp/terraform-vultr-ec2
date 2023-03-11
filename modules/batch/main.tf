resource "vultr_instance" "instance" {
  count            = var.instance-count
  plan             = var.plan
  region           = var.region
  os_id            = var.os_id
  snapshot_id      = var.snapshot_id
  ssh_key_ids      = var.ssh_key_ids
  vpc_ids          = var.vpc_ids
  label            = "${var.name}-${count.index+1}"
  hostname         = "${var.name}-${count.index+1}"
  tags             = [var.name]
  script_id        = var.script_id
  enable_ipv6      = false
  ddos_protection  = false
  activation_email = false
  backups          = "disabled"

  lifecycle {
    //noinspection HCLUnknownBlockType
    precondition {
      condition     = (var.os_id == null && var.snapshot_id != null) || (var.os_id != null && var.snapshot_id == null)
      error_message = "Either os_id or snapshot_id MUST be specified"
    }
  }
}
