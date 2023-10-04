variable "acme_email" {
  description = "ACME email"
  type        = string
}

variable "aws_access_key_id" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}

variable "aws_secret_access_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}

variable "zinc_juju_model_name" {
  description = "Name of juju model to deploy into"
  type        = string
}
