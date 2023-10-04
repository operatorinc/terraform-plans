variable "kratos_client_secret" {
  description = "Client Secret"
  type        = string
  sensitive   = true
}

variable "kratos_microsoft_tenant_id" {
  description = "Tenant ID"
  type        = string
  sensitive   = true
}

variable "sso_juju_model_name" {
  description = "SSO model name"
  type        = string
}
