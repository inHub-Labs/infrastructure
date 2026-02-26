locals {
  repo_files = fileset("${path.module}/repositories", "*.yml")

  repository_configs = [
    for repo_file in local.repo_files :
    yamldecode(file("${path.module}/repositories/${repo_file}"))
  ]

  repositories = {
    for repo in local.repository_configs : repo.name => merge(repo, {
      branch_strategy = try(length(trimspace(repo.branch_strategy)) > 0 ? trimspace(repo.branch_strategy) : "main", "main")
      visibility      = try(length(trimspace(repo.visibility)) > 0 ? lower(trimspace(repo.visibility)) : "public", "public")
      squash_merge_commit_title = try(
        length(trimspace(repo.squash_merge_commit_title)) > 0 ? upper(trimspace(repo.squash_merge_commit_title)) : null,
        null
      )
      squash_merge_commit_message = try(
        length(trimspace(repo.squash_merge_commit_message)) > 0 ? upper(trimspace(repo.squash_merge_commit_message)) : null,
        null
      )
      merge_commit_title = try(
        length(trimspace(repo.merge_commit_title)) > 0 ? upper(trimspace(repo.merge_commit_title)) : null,
        null
      )
      merge_commit_message = try(
        length(trimspace(repo.merge_commit_message)) > 0 ? upper(trimspace(repo.merge_commit_message)) : null,
        null
      )
      topics = distinct(concat(
        [
          for topic in try(repo.topics, []) :
          lower(trimspace(topic))
          if length(trimspace(topic)) > 0
        ],
        ["terraform-managed"]
      ))
    })
  }
}
