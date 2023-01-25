//noinspection HILUnresolvedReference
output "all_instances" {
  description = "All instances"
  value       = {for i in local.all_instances : i.label=>i.data}
}

//noinspection HILUnresolvedReference
output "instances" {
  description = "Instances grouped by name"
  value       = {for name, batch in module.vms : name => {for label, data in batch.instances : label => data}}
}
