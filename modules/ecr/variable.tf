variable "repository_names" {
  type    = list(string)
  description = "List of ECR repository names to be created (e.g., UI and API)"
}

variable "image_tag_mutability" {
  description = "Image tag mutability setting for the ECR repositories"
  type        = string
  default     = "MUTABLE"
}

variable "tags" {
  description = "A map of tags to assign to the ECR repositories"
  type        = map(string)
  default     = {
    "Environment" = "production"
    "Project"     = "example_project"
  }
}

variable "lifecycle_rule_priority" {
  description = "The priority of the lifecycle rule for expiring images"
  type        = number
  default     = 1
}

variable "expire_image_days" {
  description = "Number of days after which images should expire"
  type        = number
  default     = 30
}
