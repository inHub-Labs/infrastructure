/* resource "github_actions_organization_variable" "aws_assume_role" {
  variable_name = "AWS_ASSUME_ROLE"
  visibility    = "all"
  value         = "arn:aws:iam::994482169481:role/github-actions-terraform"
} */

module "repositories" {
  source   = "./modules/repository"
  for_each = local.repositories

  name        = each.value.name
  description = each.value.description
  topics      = each.value.topics
  owners      = each.value.owners
  branch_name = each.value.branch_strategy
  visibility  = each.value.visibility
}

module "members" {
  source   = "./modules/membership"
  for_each = local.members

  username = each.value.username
  role     = each.value.role
}

module "teams" {
  source   = "./modules/team"
  for_each = local.teams

  name         = each.value.name
  description  = each.value.description
  privacy      = each.value.privacy
  members      = each.value.members
  repositories = each.value.repositories
}

module "org_settings" {
  source = "./modules/org_settings"

  billing_email                           = local.org_settings.billing_email
  default_repository_permission           = try(local.org_settings.default_repository_permission, "read")
  members_can_create_repositories         = try(local.org_settings.members_can_create_repositories, false)
}