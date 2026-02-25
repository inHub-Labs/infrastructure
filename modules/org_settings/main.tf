resource "github_organization_settings" "this" {
  billing_email = var.billing_email

  default_repository_permission           = var.default_repository_permission
  members_can_create_repositories         = var.members_can_create_repositories
}
