variable "github_organization" {
  description = "GitHub organization name where repositories will be managed."
  type        = string
}

variable "github_app_id" {
  description = "GitHub App ID used by the GitHub provider app_auth block."
  type        = string
}

variable "github_app_installation_id" {
  description = "GitHub App installation ID for the target organization/account."
  type        = string
}

variable "github_app_pem_file" {
  description = "GitHub App private key in PEM format."
  type        = string
  sensitive   = true
}
