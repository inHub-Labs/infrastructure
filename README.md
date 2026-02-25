# Infrastructure

Terraform manages GitHub organization resources (repositories, teams, and members) from YAML files. CI applies changes automatically.

## Directory Structure

```
infrastructure/
├── modules/
│   ├── repository/
│   ├── team/
│   └── membership/
├── repositories/
├── teams/
├── org/
│   └── members.yaml
├── locals.tf
├── main.tf
├── outputs.tf
├── provider.tf
└── variables.tf
```

---

## Repository YAML (`repositories/<name>.yaml`)

```yaml
name: my-service
description: "What this service does"
topics:
  - backend
owners:
  - User1
branch_strategy: main
visibility: private
```

Each file creates: a GitHub repository, a `CODEOWNERS` file, a `README.md`, and branch protection (1 required review, dismiss stale, CODEOWNER approval).

---

## Team YAML (`teams/<team-name>.yaml`)

```yaml
name: platform
description: "Platform engineering team"
privacy: closed
members:
  - handle: User1
    role: maintainer
  - handle: User2
    role: member
repositories:
  - name: my-service
    permission: push
```

Each file creates: a GitHub team, team memberships, and team-to-repository access grants.

---

## Org Members (`org/members.yaml`)

Single file. Removing an entry and applying will **remove** that person from the organization.

```yaml
members:
  - username: User1
    role: admin
  - username: User2
    role: member
```

---

## CI / Workflow

`.github/workflows/terraform.yml` runs on every PR and push to `main`:

| Event | Steps |
|---|---|
| Pull Request | `init` → `validate` → `plan` |
| Push to `main` | `init` → `validate` → `apply` |

### Required Secrets

| Secret | Description |
|---|---|
| `TF_VAR_github_token` | PAT with `repo` + `admin:org` scopes |
| `TF_VAR_github_organization` | Org name |
