# Terraform: Industry Standard Practices

This repository demonstrates a common, industry-standard layout and workflow for Terraform projects targeting Azure (azurerm). It covers recommended folder structure, state management, module usage, CI/CD, and quality checks.

Repository layout
- [README.md](README.md) — this file.
- [environments/dev](environments/dev) — development environment configuration.
- [environments/prod](environments/prod) — production environment configuration.
- [modules](modules/) — reusable Terraform modules.

Key principles
- Keep modules isolated and reusable. Put reusable resources in [modules](modules/).
- Keep environment-specific configuration separate under [environments/](environments/) (dev, prod).
- Use a remote backend with locking (Azure Storage + Cosmos/Blob lock via AzureRM) for shared state.
- Pin Terraform and provider versions with required_version and required_providers blocks.
- Treat state as sensitive: never commit .tfstate or .tfstate.backup to VCS; add to .gitignore.

Recommended folder structure (example)
- modules/
  - network/
  - compute/
  - storage/
- environments/
  - dev/
    - main.tf
    - variables.tf
    - backend.tf
  - prod/
    - main.tf
    - variables.tf
    - backend.tf

State & Backends
- Use a remote backend (e.g., azurerm backend with Azure Storage) to store state and enable locking.
- Configure backend per environment (backend.tf in each env folder) and avoid committing credentials.
- Use separate state files per environment and per major logical unit to reduce blast radius.

Variables and Secrets
- Keep non-sensitive variables in variables.tf with defaults only when appropriate.
- Store secrets in a secrets manager (Azure Key Vault) and reference them at runtime; do not store secrets in tfvars checked into VCS.
- Use environment-specific tfvars files (e.g., dev.tfvars, prod.tfvars) and keep them out of source control.

Modules
- Make modules:
  - Inputs: explicit, validated via variables.
  - Outputs: limited to necessary values for composition.
  - Idempotent and well-documented.
- Version modules (tags or versions) when consumed across environments or repos.

CI/CD
- Validate changes with an automated pipeline:
  - terraform fmt -check
  - terraform init (with backend configured)
  - terraform validate
  - terraform plan -out=tfplan
  - Optional security/lint scanning (tflint, checkov)
- Use an approval step for terraform apply in production.
- Lock pipeline credentials to least privilege.

Testing & Quality
- Use terraform fmt and terraform validate as gates.
- Use tflint and static security scanners (e.g., checkov, tfsec).
- Consider integration tests using Terratest or kitchen-terraform for critical modules.

State Migration & Change Management
- Review plans carefully; require approvals for destructive changes.
- Break large changes into small, reviewable steps.
- Keep a rollback strategy and snapshots of state when performing risky migrations.

Versioning
- Pin Terraform core and provider versions in each module/root with:
  - required_version
  - required_providers
- Use module versioning for shared modules and update via controlled pull requests.

Operational notes
- Add a .gitignore that excludes:
  - .terraform/
  - *.tfstate
  - *.tfstate.backup
  - override files with sensitive data
- Document environment-specific steps in each env folder (backend configuration, required secrets).

Quick commands
- terraform fmt ./ -check
- terraform init -backend-config="..." 
- terraform validate
- terraform plan -var-file=dev.tfvars -out=tfplan
- terraform apply tfplan

References (examples in this repo)
- [environments/dev](environments/dev)
- [environments/prod](environments/prod)
- [modules](modules/)

For project-specific conventions (naming, tags, network CIDR strategy), add a CONTRIBUTING.md or a repository-specific

