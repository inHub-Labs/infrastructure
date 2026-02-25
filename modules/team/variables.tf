variable "name" {
  description = "Team name"
  type        = string

  validation {
    condition     = length(trimspace(var.name)) > 0
    error_message = "Team name must not be empty."
  }
}

variable "description" {
  description = "Team description"
  type        = string
  default     = ""
}

variable "privacy" {
  description = "Team visibility: 'closed' or 'secret'."
  type        = string
  default     = "closed"

  validation {
    condition     = contains(["closed", "secret"], var.privacy)
    error_message = "Team privacy must be 'closed' or 'secret'."
  }
}

variable "members" {
  description = "List of org members to add to this team."
  type = list(object({
    handle = string
    role   = string
  }))
  default = []

  validation {
    condition = alltrue([
      for m in var.members : contains(["maintainer", "member"], m.role)
    ])
    error_message = "Each member role must be 'maintainer' or 'member'."
  }

  validation {
    condition = alltrue([
      for m in var.members : length(trimspace(m.handle)) > 0
    ])
    error_message = "Member handles must not be empty strings."
  }
}

variable "repositories" {
  description = "List of repositories this team should have access to."
  type = list(object({
    name       = string
    permission = string
  }))
  default = []

  validation {
    condition = alltrue([
      for r in var.repositories : contains(["pull", "triage", "push", "maintain", "admin"], r.permission)
    ])
    error_message = "Repository permission must be one of: pull, triage, push, maintain, admin."
  }

  validation {
    condition = alltrue([
      for r in var.repositories : length(trimspace(r.name)) > 0
    ])
    error_message = "Repository names in teams must not be empty."
  }
}
