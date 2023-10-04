resource "juju_application" "acme" {
  name  = "acme"
  model = var.zinc_juju_model_name

  charm {
    name     = "route53-acme-operator"
    channel  = "latest/stable"
    revision = 16
    series   = "jammy"
  }

  config = {
    email                 = var.acme_email
    server                = "https://acme-v02.api.letsencrypt.org/directory"
    aws_access_key_id     = var.aws_access_key_id
    aws_secret_access_key = var.aws_secret_access_key
    aws_region            = "us-east-2"
    aws_hosted_zone_id    = "Z09310652H1HIN2ZYI3DD"
  }

  units = 1
}

resource "juju_integration" "acme_traefik_public" {
  model = var.zinc_juju_model_name

  application {
    name = juju_application.acme.name
  }

  application {
    name     = "traefik-public"
    endpoint = "certificates"
  }
}
