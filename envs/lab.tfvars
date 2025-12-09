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
