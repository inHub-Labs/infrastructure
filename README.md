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
has_issues: true
has_discussions: false
has_projects: true
has_wiki: true
allow_merge_commit: true
allow_squash_merge: true
allow_rebase_merge: true
allow_auto_merge: false
# leave unset for GitHub default behavior
# allow_forking:
# squash_merge_commit_title:
# squash_merge_commit_message:
# merge_commit_title:
# merge_commit_message:
delete_branch_on_merge: false
web_commit_signoff_required: false
archived: false
archive_on_destroy: false
# leave unset for org policy / GitHub default behavior
# vulnerability_alerts:
allow_update_branch: false
```

Required fields:

- `name`
- `description`
- `topics`
- `owners`

Optional fields:

- `branch_strategy` (default: `main`)
- `visibility` (default: `public`, allowed: `public`, `private`, `internal`)
- `has_issues` (default: `true`)
- `has_discussions` (default: `false`)
- `has_projects` (default: `true`)
- `has_wiki` (default: `true`)
- `allow_merge_commit` (default: `true`)
- `allow_squash_merge` (default: `true`)
- `allow_rebase_merge` (default: `true`)
- `allow_auto_merge` (default: `false`)
- `allow_forking` (default: unset, allowed: `true`/`false`)
- `squash_merge_commit_title` (allowed: `PR_TITLE`, `COMMIT_OR_PR_TITLE`)
- `squash_merge_commit_message` (allowed: `PR_BODY`, `COMMIT_MESSAGES`, `BLANK`)
- `merge_commit_title` (allowed: `PR_TITLE`, `MERGE_MESSAGE`)
- `merge_commit_message` (allowed: `PR_BODY`, `PR_TITLE`, `BLANK`)
- `delete_branch_on_merge` (default: `false`)
- `web_commit_signoff_required` (default: `false`)
- `auto_init` (default: `false`)
- `archived` (default: `false`)
- `archive_on_destroy` (default: `false`)
- `vulnerability_alerts` (default: unset, allowed: `true`/`false`)
- `allow_update_branch` (default: `false`)

Notes:

- `terraform-managed` is always added to repository topics automatically.
