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
