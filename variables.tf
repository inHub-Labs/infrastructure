variable "github_organization" {
  description = "GitHub organization name where repositories will be managed."
  type        = string

  validation {
    condition     = length(trimspace(var.github_organization)) > 0
    error_message = "github_organization must be a non-empty string (e.g. \"my-org\")."
  }
}

variable "github_app_id" {
  description = "GitHub App ID."
  type        = string
}

variable "github_app_installation_id" {
  description = "GitHub App installation ID."
  type        = string
}

variable "github_app_pem_file" {
  description = "GitHub App private key in PEM format."
  type        = string
  sensitive   = true
}