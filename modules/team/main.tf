terraform {
  required_providers {
    github = {
      source = "integrations/github"
    }
  }
}

resource "github_team" "this" {
  name        = var.name
  description = var.description
  privacy     = var.privacy
}

resource "github_team_membership" "members" {
  for_each = { for m in var.members : m.handle => m }

  team_id  = github_team.this.id
  username = each.value.handle
  role     = each.value.role
}

resource "github_team_repository" "repos" {
  for_each = { for r in var.repositories : r.name => r }

  team_id    = github_team.this.id
  repository = each.value.name
  permission = each.value.permission
}