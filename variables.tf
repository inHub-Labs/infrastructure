variable "github_organization" {
  description = "GitHub organization name where repositories will be managed."
  type        = string
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
