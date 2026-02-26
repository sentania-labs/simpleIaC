virtual_machines = {
  hr_vm_1a = {
    zone                        = "int.sentania.net"
    virtual_machine_name        = "hr-vm1a"
    virtual_machine_description = "Deployed via TF - Do not Edit"
    image                       = "ubuntu24"
    flavor                      = "medium"
    tags = [
      { key = "serviceLevel", value = "production" },
      { key = "application", value = "hr" }
    ]
    constraints = [
      {
        mandatory  = true
        expression = "application:hr"
      }
    ]
    image_disk_constraints = [
      {
        mandatory  = true
        expression = "storageTier:iscsi"
      }
    ]
  }
}
deployments = {
  catalogdeployment1 = {
    catalog_item_name    = "VM With Disks"
    deployment_name      = "Catalog Simple No Frills Version - 1a"
    description          = "Provisioned by TF"
    catalog_item_version = 2
    inputs = {
      flavorSize = "medium"
      diskCount  = 2
      diskSize   = 10
      image      = "ubuntu22"
    }
  }
}