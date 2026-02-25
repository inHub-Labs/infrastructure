module "repositories" {
  source   = "./modules/repository"
  for_each = local.repositories

  name            = each.value.name
  description     = each.value.description
  topics          = each.value.topics
  owners          = each.value.owners
  branch_name     = each.value.branch_strategy
  visibility      = each.value.visibility
}