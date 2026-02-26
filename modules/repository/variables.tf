variable "name" {
  type = string

  validation {
    condition     = length(trimspace(var.name)) > 0
    error_message = "Repository name must not be empty."
  }
}

variable "description" {
  type = string

  validation {
    condition     = length(trimspace(var.description)) > 0
    error_message = "Repository description must not be empty."
  }
}

variable "topics" {
  type = list(string)

  validation {
    condition     = length(var.topics) > 0
    error_message = "Repository must have at least one topic."
  }

  validation {
    condition     = alltrue([for topic in var.topics : length(trimspace(topic)) > 0])
    error_message = "Repository topics must not contain empty values."
  }
}

variable "owners" {
  type = list(string)

  validation {
    condition     = length(var.owners) > 0
    error_message = "Repository must define at least one owner."
  }

  validation {
    condition     = alltrue([for owner in var.owners : length(trimspace(owner)) > 0])
    error_message = "Repository owners must not contain empty values."
  }
}

variable "branch_name" {
  type = string

  validation {
    condition     = length(trimspace(var.branch_name)) > 0
    error_message = "Repository branch name must not be empty."
  }
}

variable "visibility" {
  type    = string
  default = "public"

  validation {
    condition     = contains(["public", "private", "internal"], var.visibility)
    error_message = "Visibility must be one of: public, private, internal."
  }
}

variable "has_issues" {
  type    = bool
  default = true
}

variable "has_discussions" {
  type    = bool
  default = false
}

variable "has_projects" {
  type    = bool
  default = true
}

variable "has_wiki" {
  type    = bool
  default = true
}

variable "allow_merge_commit" {
  type    = bool
  default = true
}

variable "allow_squash_merge" {
  type    = bool
  default = true
}

variable "allow_rebase_merge" {
  type    = bool
  default = true
}

variable "allow_auto_merge" {
  type    = bool
  default = false
}

variable "allow_forking" {
  type    = bool
  default = null
}

variable "squash_merge_commit_title" {
  type    = string
  default = null

  validation {
    condition = var.squash_merge_commit_title == null || contains([
      "PR_TITLE",
      "COMMIT_OR_PR_TITLE"
    ], var.squash_merge_commit_title)
    error_message = "squash_merge_commit_title must be one of: PR_TITLE, COMMIT_OR_PR_TITLE."
  }

  validation {
    condition     = var.squash_merge_commit_title == null || var.allow_squash_merge
    error_message = "squash_merge_commit_title can be set only when allow_squash_merge is true."
  }
}

variable "squash_merge_commit_message" {
  type    = string
  default = null

  validation {
    condition = var.squash_merge_commit_message == null || contains([
      "PR_BODY",
      "COMMIT_MESSAGES",
      "BLANK"
    ], var.squash_merge_commit_message)
    error_message = "squash_merge_commit_message must be one of: PR_BODY, COMMIT_MESSAGES, BLANK."
  }

  validation {
    condition     = var.squash_merge_commit_message == null || var.allow_squash_merge
    error_message = "squash_merge_commit_message can be set only when allow_squash_merge is true."
  }
}

variable "merge_commit_title" {
  type    = string
  default = null

  validation {
    condition = var.merge_commit_title == null || contains([
      "PR_TITLE",
      "MERGE_MESSAGE"
    ], var.merge_commit_title)
    error_message = "merge_commit_title must be one of: PR_TITLE, MERGE_MESSAGE."
  }

  validation {
    condition     = var.merge_commit_title == null || var.allow_merge_commit
    error_message = "merge_commit_title can be set only when allow_merge_commit is true."
  }
}

variable "merge_commit_message" {
  type    = string
  default = null

  validation {
    condition = var.merge_commit_message == null || contains([
      "PR_BODY",
      "PR_TITLE",
      "BLANK"
    ], var.merge_commit_message)
    error_message = "merge_commit_message must be one of: PR_BODY, PR_TITLE, BLANK."
  }

  validation {
    condition     = var.merge_commit_message == null || var.allow_merge_commit
    error_message = "merge_commit_message can be set only when allow_merge_commit is true."
  }
}

variable "delete_branch_on_merge" {
  type    = bool
  default = false
}

variable "web_commit_signoff_required" {
  type    = bool
  default = false
}

variable "archived" {
  type    = bool
  default = false
}

variable "archive_on_destroy" {
  type    = bool
  default = false
}

variable "vulnerability_alerts" {
  type    = bool
  default = null
}

variable "allow_update_branch" {
  type    = bool
  default = false
}
