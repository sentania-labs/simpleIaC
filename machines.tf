#Catalog Item request
module "machine" {
  source   = "sentania-labs/vmapps-vra-machine/vra"
  version  = "0.1.0"
  for_each = var.virtual_machines

  virtual_machine_name       = each.value.virtual_machine_name
  virtual_machine_description = each.value.virtual_machine_description
  project_name               = each.value.project_name
  image                      = each.value.image
  flavor                     = each.value.flavor
}