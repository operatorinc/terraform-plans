resource "juju_model" "cos" {
  name = "observability"
}

resource "juju_application" "traefik" {
  name  = "traefik"
  model = juju_model.cos.name

  charm {
    name     = "traefik-k8s"
    channel  = "latest/candidate"
    revision = 148
  }

  units = 1
}

resource "juju_application" "alertmanager" {
  name  = "alertmanager"
  model = juju_model.cos.name

  charm {
    name     = "alertmanager-k8s"
    channel  = "latest/stable"
    revision = 77
  }

  units = 1
  trust = true
}

resource "juju_application" "loki" {
  name  = "loki"
  model = juju_model.cos.name

  charm {
    name     = "loki-k8s"
    channel  = "latest/stable"
    revision = 91
  }

  units = 1
  trust = true
}

resource "juju_application" "prometheus" {
  name  = "prometheus"
  model = juju_model.cos.name

  charm {
    name     = "prometheus-k8s"
    channel  = "latest/stable"
    revision = 129
  }

  units = 1
  trust = true
}

resource "juju_application" "grafana" {
  name  = "grafana"
  model = juju_model.cos.name

  charm {
    name     = "grafana-k8s"
    channel  = "latest/stable"
    revision = 82
  }

  units = 1
  trust = true
}

resource "juju_application" "catalogue" {
  name  = "catalogue"
  model = juju_model.cos.name

  charm {
    name     = "catalogue-k8s"
    channel  = "latest/stable"
    revision = 19
  }

  units = 1
}

resource "juju_integration" "alertmanager_grafana_dashboard" {
  model = juju_model.cos.name

  application {
    name = juju_application.alertmanager.name
  }

  application {
    name     = juju_application.grafana.name
    endpoint = "grafana-dashboard"
  }
}

resource "juju_integration" "alertmanager_grafana_source" {
  model = juju_model.cos.name

  application {
    name = juju_application.alertmanager.name
  }

  application {
    name     = juju_application.grafana.name
    endpoint = "grafana-source"
  }
}

resource "juju_integration" "alertmanager_catalogue" {
  model = juju_model.cos.name

  application {
    name = juju_application.alertmanager.name
  }

  application {
    name     = juju_application.catalogue.name
    endpoint = "catalogue"
  }
}

resource "juju_integration" "alertmanager_loki" {
  model = juju_model.cos.name

  application {
    name = juju_application.alertmanager.name
  }

  application {
    name = juju_application.loki.name
  }
}

resource "juju_integration" "alertmanager_prometheus_alertmananager" {
  model = juju_model.cos.name

  application {
    name = juju_application.alertmanager.name
  }

  application {
    name     = juju_application.prometheus.name
    endpoint = "alertmanager"
  }
}

resource "juju_integration" "alertmanager_prometheus_metrics" {
  model = juju_model.cos.name

  application {
    name = juju_application.alertmanager.name
  }

  application {
    name     = juju_application.prometheus.name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "grafana_prometheus" {
  model = juju_model.cos.name

  application {
    name = juju_application.grafana.name
  }

  application {
    name     = juju_application.prometheus.name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "grafana_catalogue" {
  model = juju_model.cos.name

  application {
    name = juju_application.grafana.name
  }

  application {
    name     = juju_application.catalogue.name
    endpoint = "catalogue"
  }
}

resource "juju_integration" "loki_grafana_dashboard" {
  model = juju_model.cos.name

  application {
    name = juju_application.loki.name
  }

  application {
    name     = juju_application.grafana.name
    endpoint = "grafana-dashboard"
  }
}

resource "juju_integration" "loki_grafana_source" {
  model = juju_model.cos.name

  application {
    name = juju_application.loki.name
  }

  application {
    name     = juju_application.grafana.name
    endpoint = "grafana-source"
  }
}

resource "juju_integration" "loki_prometheus" {
  model = juju_model.cos.name

  application {
    name = juju_application.loki.name
  }

  application {
    name = juju_application.prometheus.name
  }
}

resource "juju_integration" "prometheus_grafana_dashboard" {
  model = juju_model.cos.name

  application {
    name = juju_application.prometheus.name
  }

  application {
    name     = juju_application.grafana.name
    endpoint = "grafana-dashboard"
  }
}

resource "juju_integration" "prometheus_catalogue" {
  model = juju_model.cos.name

  application {
    name = juju_application.prometheus.name
  }

  application {
    name     = juju_application.catalogue.name
    endpoint = "catalogue"
  }
}

resource "juju_integration" "prometheus_grafana_source" {
  model = juju_model.cos.name

  application {
    name = juju_application.prometheus.name
  }

  application {
    name     = juju_application.grafana.name
    endpoint = "grafana-source"
  }
}

resource "juju_integration" "traefik_alertmanager" {
  model = juju_model.cos.name

  application {
    name = juju_application.alertmanager.name
  }

  application {
    name     = juju_application.traefik.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "traefik_loki" {
  model = juju_model.cos.name

  application {
    name = juju_application.loki.name
  }

  application {
    name     = juju_application.traefik.name
    endpoint = "ingress-per-unit"
  }
}

resource "juju_integration" "traefik_prometheus" {
  model = juju_model.cos.name

  application {
    name = juju_application.prometheus.name
  }

  application {
    name     = juju_application.traefik.name
    endpoint = "ingress-per-unit"
  }
}

resource "juju_integration" "traefik_grafana" {
  model = juju_model.cos.name

  application {
    name = juju_application.grafana.name
  }

  application {
    name     = juju_application.traefik.name
    endpoint = "traefik-route"
  }
}

resource "juju_integration" "traefik_catalogue" {
  model = juju_model.cos.name

  application {
    name = juju_application.traefik.name
  }

  application {
    name     = juju_application.catalogue.name
    endpoint = "ingress"
  }
}

resource "juju_integration" "prometheus_traefik" {
  model = juju_model.cos.name

  application {
    name = juju_application.prometheus.name
  }

  application {
    name     = juju_application.traefik.name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_offer" "grafana_dashboard" {
  model            = juju_model.cos.name
  application_name = juju_application.grafana.name
  endpoint         = "grafana-dashboard"
}

resource "juju_offer" "loki_logging" {
  model            = juju_model.cos.name
  application_name = juju_application.loki.name
  endpoint         = "logging"
}

resource "juju_offer" "prometheus_scrape" {
  model            = juju_model.cos.name
  application_name = juju_application.prometheus.name
  endpoint         = "metrics-endpoint"
}

resource "juju_integration" "prometheus_zinc" {
  model = var.zinc_juju_model_name

  application {
    offer_url = juju_offer.prometheus_scrape.url
  }

  application {
    name     = "zinc"
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "zinc_grafana_dashboard" {
  model = var.zinc_juju_model_name

  application {
    name     = "zinc"
    endpoint = "grafana-dashboard"
  }

  application {
    offer_url = juju_offer.grafana_dashboard.url
  }
}

# Not supported
# resource "juju_integration" "zinc_loki" {
#   model = var.zinc_juju_model_name
# 
#   application {
#     name     = "zinc"
#     endpoint = "log-proxy"
#   }
# 
#   application {
#     offer_url = juju_offer.loki_logging.url
#   }
# }


resource "juju_integration" "prometheus_traefik_public" {
  model = var.zinc_juju_model_name

  application {
    offer_url = juju_offer.prometheus_scrape.url
  }

  application {
    name     = "traefik-public"
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "grafana_traefik_public" {
  model = var.zinc_juju_model_name

  application {
    offer_url = juju_offer.grafana_dashboard.url
  }

  application {
    name     = "traefik-public"
    endpoint = "grafana-dashboard"
  }
}

resource "juju_integration" "prometheus_traefik_admin" {
  model = var.zinc_juju_model_name

  application {
    offer_url = juju_offer.prometheus_scrape.url
  }

  application {
    name     = "traefik-admin"
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "grafana_traefik_admin" {
  model = var.zinc_juju_model_name

  application {
    offer_url = juju_offer.grafana_dashboard.url
  }

  application {
    name     = "traefik-admin"
    endpoint = "grafana-dashboard"
  }
}
