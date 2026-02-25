output "repositories" {
  value = {
    for repo_name, repo_module in module.repositories : repo_name => {
      name           = repo_module.name
      html_url       = repo_module.html_url
    }
  }
}