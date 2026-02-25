terraform {
  required_providers {
    github = {
      source = "integrations/github"
    }
  }
}

resource "github_membership" "this" {
  username = var.username
  role     = var.role
}