variable "github_organization" {
  description = "GitHub organization name where repositories will be managed."
  type        = string

  validation {
    condition     = length(trimspace(var.github_organization)) > 0
    error_message = "github_organization must be a non-empty string (e.g. \"my-org\")."
  }
}

variable "github_token" {
  description = "GitHub Personal Access Token with repo and admin:org scopes."
  type        = string
  sensitive   = true
}