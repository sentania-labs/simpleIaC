virtual_machines = {
  hr_vm_3a = {
    zone                        = "int.sentania.net"
    virtual_machine_name        = "hr-vm3a"
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
  catalogdeployment2026 = {
    catalog_item_name    = "VM With Disks"
    deployment_name      = "Ubuntu Deployment - 2026-02-09"
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
  blueprintdeployment2026 = {
    blueprint_name    = "VM With Disks"
    deployment_name   = "Ubuntu Deployment - 2026-02-09 - BP"
    description       = "Provisioned by TF"
    blueprint_version = "explicittags"
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