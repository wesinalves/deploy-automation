# ... existing code ...

variable "ecr_image_api" {
  description = "ECR Image for API"
  default     = "<APP ECR Image URL>:latest"
}

variable "ecr_image_proxy" {
  description = "ECR Image for API"
  default     = "<App ECR Image for Proxy>:latest"
}

variable "django_secret_key" {
  description = "Secret key for Django app"
}