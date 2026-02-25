# Infrastructure

Terraform manages GitHub repositories from YAML files in `repositories/`.

## Authentication

The GitHub provider uses GitHub App authentication (`app_auth`) via environment variables.
Provider config keeps an empty `app_auth {}` block to allow env-based auth.

Required inputs:

- `github_organization`
- `GITHUB_APP_ID`
- `GITHUB_APP_INSTALLATION_ID`
- `GITHUB_APP_PEM_FILE`

In GitHub Actions, these are mapped from repository secrets:

- `TF_GITHUB_APP_ID` -> `GITHUB_APP_ID`
- `TF_GITHUB_APP_INSTALLATION_ID` -> `GITHUB_APP_INSTALLATION_ID`
- `TF_GITHUB_APP_PRIVATE_KEY` -> `GITHUB_APP_PEM_FILE`

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
