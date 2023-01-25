variable "region" {
  description = "Region of deployment"
  type = string
}
variable "os_id" {
  description = "OS id. Must be null if snapshot_id provided."
  type = number
}
variable "snapshot_id" {
  description = "Snapshot id. Must be null if os_id provided."
  type = string
}
variable "vpc_ids" {
  type = list(string)
}
variable "ssh_key_name" {
  type = string
}
variable "vm_instances" {
  description = "Main configuration"
  type = map(object({
    plan           = string
    count          = number
    startup_script = string
  }))
}
