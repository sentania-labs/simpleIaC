# simpleIaC

A streamlined Terraform-based framework for deploying **any Aria Automation / VCF Automation blueprint or catalog item** using a single-pass plan and a clean variable-driven model.

This repository provides:
- A top-level Terraform configuration that deploys blueprints and catalog items via the vRA provider.
- A machine deployment path for direct VM provisioning without a blueprint.
- Optional output exports (IP addresses, deployment IDs) for downstream integrations.

The design avoids circular dependencies and multi-pass planning by consuming the `sentania-labs/deployment/vra` and `sentania-labs/machine/vra` registry modules.

---

## Repository Structure

```
simpleIaC/
├── backend.tf              # S3 remote state backend
├── deployments.tf          # Blueprint / catalog item deployments (uses sentania-labs/deployment/vra)
├── machines.tf             # Direct VM provisioning (uses sentania-labs/machine/vra)
├── provider.tf             # vRA + DNS provider config
├── variables.tf            # All input declarations
├── versions.tf             # Required providers and versions
├── output-template.tpl     # Templatefile for generating per-VM output
├── envs/
│   └── lab.tfvars          # Lab environment example
└── exampleblueprints/      # Sample blueprint YAML definitions
```

---

## Using This Repository

### 1. Clone the repo

```bash
git clone https://github.com/sentania-labs/simpleIaC
cd simpleIaC
```

### 2. Copy an env file

```bash
cp envs/lab.tfvars envs/my-env.tfvars
```

### 3. Edit your TF vars

The two primary input maps are `deployments` (blueprint/catalog-item deploys) and `virtual_machines` (direct VM provisions). Example:

```hcl
vcfa_url           = "https://vcfa.lab.local"
vcfa_refresh_token = "REDACTED"
vcfa_organization  = "my-org"
project_name       = "my-project"

deployments = {
  my_blueprint_deploy = {
    catalog_item_name = "VM With Disks"
    deployment_name   = "my-deploy-1"
    description       = "Provisioned by TF"
    inputs = {
      flavorSize = "medium"
      diskCount  = 2
    }
  }
}

virtual_machines = {}
```

### 4. Initialize and apply

```bash
terraform init -backend-config="key=simpleiac/my-env.tfstate"
terraform plan -var-file="envs/my-env.tfvars"
terraform apply -var-file="envs/my-env.tfvars"
```

---

## Outputs

The deployment generates a rendered `output-template.tpl` file listing deployed VMs and their IP addresses.

---

## License

MIT — use freely in your lab, enterprise, or demos.
