locals {
  external_hostname    = "staging.operatorinc.org"
  sso_juju_model_name  = "stg-zinc-deploy"
  zinc_juju_model_name = "stg-zinc-deploy"
  zinc_units           = 2
}

module "zinc" {
  source = "../../modules/zinc"

  external_hostname    = local.external_hostname
  zinc_juju_model_name = local.zinc_juju_model_name
  zinc_units           = local.zinc_units
}

module "certificates" {
  source = "../../modules/certificates"

  acme_email            = var.acme_email
  aws_access_key_id     = var.aws_access_key_id
  aws_secret_access_key = var.aws_secret_access_key
  zinc_juju_model_name  = local.zinc_juju_model_name
}

module "sso" {
  source = "../../modules/sso"

  sso_juju_model_name        = local.sso_juju_model_name
  kratos_microsoft_tenant_id = var.kratos_microsoft_tenant_id
  kratos_client_secret       = var.kratos_client_secret
}

module "cos" {
  source = "../../modules/cos"

  zinc_juju_model_name = local.zinc_juju_model_name
}
