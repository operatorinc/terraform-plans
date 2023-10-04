variable "external_hostname" {
  description = "The external hostname that the zinc app should be reachable on"
  type        = string
}

variable "zinc_juju_model_name" {
  description = "Name of juju model to deploy into"
  type        = string
}

variable "zinc_units" {
  description = "Number of zinc units to deploy"
  type        = number
}
