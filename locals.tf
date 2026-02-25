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
}
