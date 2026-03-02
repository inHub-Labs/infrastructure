resource "github_organization_settings" "this" {
  billing_email = var.billing_email

  default_repository_permission               = var.default_repository_permission
  members_can_create_repositories             = var.members_can_create_repositories

  members_can_create_public_repositories      = var.members_can_create_repositories
  members_can_create_private_repositories     = var.members_can_create_repositories
  members_can_create_pages                    = var.members_can_create_repositories
  members_can_create_public_pages             = var.members_can_create_repositories
  members_can_create_private_pages            = var.members_can_create_repositories
}
