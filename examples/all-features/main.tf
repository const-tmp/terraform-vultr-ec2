terraform {
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = ">= 2.12.0"
    }
  }
}

resource "vultr_vpc" "vpc" {
  region = "ewr"
}

locals {
  vault-consul = templatefile(
    "${path.root}/../../../scripts/install-hashicorp.sh.tmpl",
    { packages : "vault consul" }
  )
}

module "vms" {
  source       = "../.."
  region       = "ewr"
  ssh_key_name = "ecdsa"
  os_id        = 1743
  snapshot_id  = null
  vpc_ids      = [vultr_vpc.vpc.id]
  vm_instances = {
    vault = {
      plan           = "vc2-1c-1gb"
      count          = 1
      startup_script = local.vault-consul
    }
    consul = {
      plan           = "vc2-1c-1gb"
      count          = 1
      startup_script = local.vault-consul
    }
  }
}

//noinspection HILUnresolvedReference
output "data" {
  value = {for k, v in module.vms.all_instances : k=> { public_ip = v.public_ip }}
}
