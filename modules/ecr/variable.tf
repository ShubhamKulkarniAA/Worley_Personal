variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "Specifies whether images in the repository can be tagged with the same tag"
  type        = string
  default     = "MUTABLE"  # Options: MUTABLE or IMMUTABLE
}

variable "tags" {
  description = "A mapping of tags to assign to the repository"
  type        = map(string)
  default     = {}
}
