locals {

  repo_files = fileset("${path.module}/repositories", "*.yaml")

  repository_configs = [
    for repo_file in local.repo_files :
    yamldecode(file("${path.module}/repositories/${repo_file}"))
  ]

  repositories = {
    for repo in local.repository_configs : repo.name => merge(repo, {
      branch_strategy = try(length(trimspace(repo.branch_strategy)) > 0 ? trimspace(repo.branch_strategy) : "main", "main")
      visibility      = try(length(trimspace(repo.visibility)) > 0 ? lower(trimspace(repo.visibility)) : "public", "public")
    })
  }

  team_files = fileset("${path.module}/teams", "*.yaml")

  team_configs = [
    for team_file in local.team_files :
    yamldecode(file("${path.module}/teams/${team_file}"))
  ]

  teams = {
    for team in local.team_configs : team.name => merge({
      description  = ""
      privacy      = "closed"
      members      = []
      repositories = []
    }, team)
  }

  org_config = yamldecode(file("${path.module}/org/members.yaml"))

  members = {
    for m in local.org_config.members : m.username => merge({
      role = "member"
    }, m)
  }

  org_settings = yamldecode(file("${path.module}/org/settings.yaml"))
}
