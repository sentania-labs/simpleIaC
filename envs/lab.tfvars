virtual_machines = {
  test_constraints = {
    virtual_machine_name        = "iac"
    virtual_machine_description = "Deployed via TF - Do not Edit"
    image                       = "ubuntu24"
    flavor                      = "small"
    tags = [
      { key = "serviceLevel", value = "production" },
      { key = "application", value = "finance" }
    ]
    constraints = [
      {
        mandatory  = true
        expression = "application:finance"
      }
    ]
    image_disk_constraints = [
      {
        mandatory  = true
        expression = "storageTier:iscsi"
      }
    ]
  },
  hr_vm_1 = {
    virtual_machine_name        = "hr-vm"
    virtual_machine_description = "Deployed via TF - Do not Edit"
    image                       = "ubuntu24"
    flavor                      = "small"
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
  version2 = {
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
  version3 = {
    catalog_item_name    = "VM With Disks"
    deployment_name      = "Ubuntu Deployment with vSphere Tags Array"
    description          = "Provisioned by TF"
    catalog_item_version = 3
    inputs = {
      flavorSize = "medium"
      diskCount  = 2
      diskSize   = 10
      image      = "ubuntu22"
      tags = [
        { key = "serviceLevel", value = "production" },
        { key = "application", value = "finance" }
      ]
    }
  }
  explicittags = {
    catalog_item_name    = "VM With Disks"
    deployment_name      = "Ubuntu Deployment with vSphere with required tags"
    description          = "Provisioned by TF"
    catalog_item_version = "explicittags"
    inputs = {
      flavorSize   = "medium"
      diskCount    = 2
      diskSize     = 10
      image        = "ubuntu24"
      serviceLevel = "sandbox"
      application  = "sandbox"
    }
  }
}