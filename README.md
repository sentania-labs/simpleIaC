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
├── backend.tf              # S3 remote state backend (lab S3)
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

## What this repo owns, and state

This repo owns the VCF Automation deployments and machines declared in `deployments.tf`, `machines.tf` and `envs/lab.tfvars`. Its Terraform state lives on the lab S3 (bucket `tfstate` at `https://s3.int.sentania.net:9443`, key `vra/simpleiac/lab/terraform.tfstate`, lock file via `use_lockfile`). Only lab runners (label `lab`) can reach it. State has never been written, so the first apply creates everything the config declares.

CI (`.github/workflows/deployment.yml`) runs on the `lab` runner pool:

- Pull requests run only credential-free checks (fmt, `init -backend=false`, validate), so an untrusted branch never sees the S3, VCFA or GitHub secrets.
- Pushes to `main` run the same checks plus a credentialed **plan only**.
- Apply is manual: run the workflow with `workflow_dispatch` from the Actions tab and enter `apply` in the `confirm_apply` input. Any other value plans only.

### First apply

1. An org admin scopes the org secrets `TF_STATE_S3_ACCESS_KEY_ID` and `TF_STATE_S3_SECRET_ACCESS_KEY` to this repository.
2. Open a PR and merge it once the checks pass. The push to `main` runs the plan; read it in the job log and confirm it is what you want created.
3. Run the workflow manually with `confirm_apply = apply`.

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

Give every custom environment its own state key. `backend.tf` defaults to the lab key (`vra/simpleiac/lab/terraform.tfstate`), so an init without the override would plan against, and could destroy, the lab resources.

```bash
terraform init -backend-config="key=vra/simpleiac/my-env/terraform.tfstate"
terraform plan -var-file="envs/my-env.tfvars"
terraform apply -var-file="envs/my-env.tfvars"
```

---

## Outputs

The deployment generates a rendered `output-template.tpl` file listing deployed VMs and their IP addresses.

---

## License

MIT — use freely in your lab, enterprise, or demos.
