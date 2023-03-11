data "vultr_ssh_key" "ssh_key" {
  filter {
    name   = "name"
    values = [var.ssh_key_name]
  }
}

resource "vultr_startup_script" "startup-script" {
  for_each = var.vm_instances
  name     = "${each.key}-startup-script"
  script   = base64encode(each.value.startup_script)
}

module "vms" {
  for_each       = var.vm_instances
  source         = "./modules/batch"
  instance-count = each.value.count
  name           = each.key
  os_id          = var.os_id
  plan           = each.value.plan
  region         = var.region
  snapshot_id    = var.snapshot_id
  ssh_key_ids    = [data.vultr_ssh_key.ssh_key.id]
  vpc_ids        = var.vpc_ids
  script_id      = vultr_startup_script.startup-script[each.key].id
}
