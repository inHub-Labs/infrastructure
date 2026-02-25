variable "github_token" {
  description = "GitHub token used by the provider."
  type      = string
  sensitive = true
}

variable "github_organization" {
  description = "GitHub organization name where repositories will be managed."
  type = string
}
