output "instances" {
  description = "Instances grouped by name"
  value       = {for name, batch in module.vms : name => {for label, data in batch.instances : label => data}}
}

output "all_instances" {
  description = "All instances"
  value       = merge([for name, batch in module.vms : {for label, data in batch.instances : label => data}]...)
}
