virtual_machines = {
  hr_vm_1 = {
    virtual_machine_name        = "hr-vm"
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
  },
  hr_vm_2 = {
    virtual_machine_name        = "hr-vm2"
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
  catalog_item_no_tags = {
    catalog_item_name    = "VM With Disks"
    deployment_name      = "Simple No Frills Version 2"
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