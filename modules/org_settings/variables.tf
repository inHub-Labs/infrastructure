variable "billing_email" {
  description = "Billing email address for the organization (required by GitHub)."
  type        = string
}

variable "default_repository_permission" {
  type    = string
  default = "read"
}

variable "members_can_create_repositories" {
  type    = bool
  default = false
}