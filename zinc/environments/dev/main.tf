locals {
  external_hostname    = "dev.operatorinc.org"
  zinc_juju_model_name = "dev-zinc"
  zinc_units           = 1
}

module "zinc" {
  source = "../../modules/zinc"

  external_hostname    = local.external_hostname
  zinc_juju_model_name = local.zinc_juju_model_name
  zinc_units           = local.zinc_units
}
