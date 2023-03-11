output "instances" {
  value = {for i in vultr_instance.instance : i.label => i}
}
