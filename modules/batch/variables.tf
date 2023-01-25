variable "plan" {
  type = string
}
variable "region" {
  type = string
}
variable "os_id" {
  type = number
}
variable "snapshot_id" {
  type = string
}
variable "ssh_key_ids" {
  type = list(string)
}
variable "vpc_ids" {
  type = list(string)
}
variable "name" {
  type = string
}
variable "instance-count" {
  type = number
}
variable "script_id" {
  description = ""
  type = string
}

