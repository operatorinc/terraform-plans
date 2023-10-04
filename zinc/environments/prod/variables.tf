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

variable "kratos_microsoft_tenant_id" {
  description = "Tenant ID"
  type        = string
  sensitive   = true
}

variable "kratos_client_secret" {
  description = "Client Secret"
  type        = string
  sensitive   = true
}
