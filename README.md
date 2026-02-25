# Infrastructure

Terraform manages GitHub repositories from YAML files in `repositories/`.

## Authentication

The GitHub provider uses GitHub App authentication (`app_auth`) via Terraform variables.
In CI, variables are provided through `TF_VAR_*` environment variables.

Required inputs:

- `github_organization`
- `github_app_id`
- `github_app_installation_id`
- `github_app_pem_file`

In GitHub Actions, values are mapped from repository secrets:

- `TF_GITHUB_APP_ID` -> `TF_VAR_github_app_id`
- `TF_GITHUB_APP_INSTALLATION_ID` -> `TF_VAR_github_app_installation_id`
- `TF_GITHUB_APP_PRIVATE_KEY` -> `TF_VAR_github_app_pem_file`

## Structure

- `provider.tf`: Terraform and GitHub provider configuration.
- `locals.tf`: YAML loading and normalization (`branch_strategy`, `visibility`).
- `main.tf`: Module orchestration for all repositories.
- `modules/repository`: Reusable module for repository resources.

## Repository YAML schema

Example:

```yaml
name: test
description: test processing service
topics:
  - backend
  - test
owners:
  - skaletto-l
branch_strategy: main
visibility: public
```

Required fields:

- `name`
- `description`
- `topics`
- `owners`

Optional fields:

- `branch_strategy` (default: `main`)
- `visibility` (default: `public`, allowed: `public`, `private`, `internal`)
