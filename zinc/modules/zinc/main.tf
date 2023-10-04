resource "juju_model" "zinc" {
  name = var.zinc_juju_model_name
}

resource "juju_application" "zinc" {
  name  = "zinc"
  model = juju_model.zinc.name

  charm {
    name     = "zinc-k8s"
    channel  = "latest/edge"
    revision = 125
    series   = "jammy"
  }

  units = var.zinc_units
}

resource "juju_application" "traefik_public" {
  name  = "traefik-public"
  model = juju_model.zinc.name

  charm {
    name     = "traefik-k8s"
    channel  = "latest/candidate"
    revision = 148
  }

  config = {
    external_hostname = var.external_hostname
  }

  units = 1
}

resource "juju_integration" "zinc_traefik_public_ingress" {
  model = juju_model.zinc.name

  application {
    name = juju_application.zinc.name
  }

  application {
    name     = juju_application.traefik_public.name
    endpoint = "ingress"
  }
}
