output "instances" {
  value = {
    for i in vultr_instance.instance : i.label => {
      private_ip       = i.internal_ip,
      public_ip        = i.main_ip,
      default_password = i.default_password
    }
  }
}
