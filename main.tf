module "repositories" {
  source   = "./modules/repository"
  for_each = local.repositories

  name                        = each.value.name
  description                 = each.value.description
  topics                      = each.value.topics
  owners                      = each.value.owners
  branch_name                 = each.value.branch_strategy
  visibility                  = each.value.visibility
  has_issues                  = try(each.value.has_issues, true)
  has_discussions             = try(each.value.has_discussions, false)
  has_projects                = try(each.value.has_projects, true)
  has_wiki                    = try(each.value.has_wiki, true)
  allow_merge_commit          = try(each.value.allow_merge_commit, true)
  allow_squash_merge          = try(each.value.allow_squash_merge, true)
  allow_rebase_merge          = try(each.value.allow_rebase_merge, true)
  allow_auto_merge            = try(each.value.allow_auto_merge, false)
  allow_forking               = try(each.value.allow_forking, null)
  squash_merge_commit_title   = try(each.value.squash_merge_commit_title, null)
  squash_merge_commit_message = try(each.value.squash_merge_commit_message, null)
  merge_commit_title          = try(each.value.merge_commit_title, null)
  merge_commit_message        = try(each.value.merge_commit_message, null)
  delete_branch_on_merge      = try(each.value.delete_branch_on_merge, false)
  web_commit_signoff_required = try(each.value.web_commit_signoff_required, false)
  auto_init                   = try(each.value.auto_init, false)
  archived                    = try(each.value.archived, false)
  archive_on_destroy          = try(each.value.archive_on_destroy, false)
  vulnerability_alerts        = try(each.value.vulnerability_alerts, null)
  allow_update_branch         = try(each.value.allow_update_branch, false)
}
