#Catalog Item request
module "deployments" {
  source   = "sentania-labs/vmapps-consume-catalogitem/vra"
  version  = "0.5.0"
  for_each = var.deployments

  project_name         = each.value.project_name
  deployment_name      = each.value.deployment_name
  description          = each.value.description
  catalog_item_name    = each.value.catalog_item_name
  catalog_item_version = each.value.catalog_item_version
  inputs               = each.value.inputs
}


data "vra_machine" "all" {
  for_each = {
    for k, m in module.deployments :
    k => m.deployment_info
  }

  filter = "deploymentId eq '${each.value.id}'"
}

resource "local_file" "lb_config" {
  content = templatefile("${path.module}/output-template.tpl", {
    nodes = data.vra_machine.all
  })
  filename = "${path.module}/server-list.txt"
}
