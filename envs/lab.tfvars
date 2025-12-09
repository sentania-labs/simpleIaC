virtual_machines = {
  myfirstvirtualmachine = {
    virtual_machine_name       = "iac"
    virtua_machine_description = "Deployed via TF - Do not Edit"
    image                      = "ubuntu24"
    flavor                     = "small"
  }
}

deployments = {
  version2 = {
    project_name         = "VCF Lab Sandbox"
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
    project_name         = "VCF Lab Sandbox"
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
    project_name         = "VCF Lab Sandbox"
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