terraform {
  required_providers {
    github = {
      source = "integrations/github"
    }
  }
}

resource "github_repository" "this" {
  name        = var.name
  homepage_url = "https://github.com/InformationSystemsAgency/vcs-automation"
  description = var.description
  visibility  = var.visibility
  topics      = var.topics
  auto_init   = true
}

resource "github_repository_file" "codeowners" {
  repository          = github_repository.this.name
  file                = "CODEOWNERS"
  branch              = var.branch_name
  overwrite_on_create = true

  content = join("\n", [
    for owner in var.owners :
    "* @${owner}"
  ])
}

resource "github_repository_file" "readme" {
  repository          = github_repository.this.name
  file                = "README.md"
  branch              = var.branch_name
  overwrite_on_create = true

  content = "# ${var.name}\n\n${var.description}\n\nManaged via Infrastructure."

  lifecycle {
    ignore_changes = [content]
  }
}

resource "github_branch_protection" "this" {
  repository_id = github_repository.this.node_id
  pattern       = var.branch_name

  enforce_admins = true

  required_pull_request_reviews {
    required_approving_review_count = 1
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
  }

  allows_force_pushes = false
  allows_deletions    = false

  depends_on = [
    github_repository_file.readme,
    github_repository_file.codeowners
  ]
}
