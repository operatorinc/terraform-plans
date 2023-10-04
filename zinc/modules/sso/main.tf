resource "juju_application" "hydra" {
  name  = "hydra"
  model = var.sso_juju_model_name

  charm {
    name     = "hydra"
    channel  = "0.1/edge"
    revision = 260
    series   = "jammy"
  }

  units = 1
}

resource "juju_application" "kratos" {
  name  = "kratos"
  model = var.sso_juju_model_name

  charm {
    name     = "kratos"
    channel  = "0.1/edge"
    revision = 376
    series   = "jammy"
  }

  units = 1
}

resource "juju_application" "postgres" {
  name  = "postgresql"
  model = var.sso_juju_model_name

  charm {
    name     = "postgresql-k8s"
    channel  = "14/stable"
    revision = 73
    series   = "jammy"
  }

  units = 1
  trust = true
}

resource "juju_application" "identity_platform_login_ui_operator" {
  name  = "identity-platform-login-ui-operator"
  model = var.sso_juju_model_name

  charm {
    name     = "identity-platform-login-ui-operator"
    channel  = "0.1/edge"
    revision = 71
    series   = "jammy"
  }

  units = 1
}

resource "juju_application" "kratos_external_idp_integrator" {
  name  = "kratos-external-idp-integrator"
  model = var.sso_juju_model_name

  charm {
    name     = "kratos-external-idp-integrator"
    channel  = "0.1/edge"
    revision = 182
    series   = "jammy"
  }

  config = {
    microsoft_tenant_id = var.kratos_microsoft_tenant_id
    provider            = "microsoft"
    client_id           = "bf7ca934-18d9-4726-b0b0-a0d0ac7105f9"
    client_secret       = var.kratos_client_secret
  }

  units = 1
}

resource "juju_application" "self_signed_certificates" {
  name  = "self-signed-certificates"
  model = var.sso_juju_model_name

  charm {
    name     = "self-signed-certificates"
    channel  = "edge"
    revision = 30
    series   = "jammy"
  }

  units = 1
}


resource "juju_application" "traefik_admin" {
  name  = "traefik-admin"
  model = var.sso_juju_model_name

  charm {
    name     = "traefik-k8s"
    channel  = "latest/edge"
    revision = 149
    series   = "focal"
  }

  units = 1
}

resource "juju_integration" "hydra_identity_platform_login_ui_operator_ui" {
  model = var.sso_juju_model_name

  application {
    name     = juju_application.hydra.name
    endpoint = "ui-endpoint-info"
  }

  application {
    name     = juju_application.identity_platform_login_ui_operator.name
    endpoint = "ui-endpoint-info"
  }
}

resource "juju_integration" "hydra_identity_platform_login_ui_operator_hydra" {
  model = var.sso_juju_model_name

  application {
    name     = juju_application.identity_platform_login_ui_operator.name
    endpoint = "hydra-endpoint-info"
  }

  application {
    name     = juju_application.hydra.name
    endpoint = "hydra-endpoint-info"
  }
}

resource "juju_integration" "hydra_kratos" {
  model = var.sso_juju_model_name

  application {
    name     = juju_application.hydra.name
    endpoint = "hydra-endpoint-info"
  }

  application {
    name     = juju_application.kratos.name
    endpoint = "hydra-endpoint-info"
  }
}

resource "juju_integration" "kratos_identity_platform_login_ui_operator_ui" {
  model = var.sso_juju_model_name

  application {
    name     = juju_application.identity_platform_login_ui_operator.name
    endpoint = "ui-endpoint-info"
  }

  application {
    name     = juju_application.kratos.name
    endpoint = "ui-endpoint-info"
  }
}

resource "juju_integration" "kratos_kratos_external_idp_integrator" {
  model = var.sso_juju_model_name

  application {
    name     = juju_application.kratos_external_idp_integrator.name
    endpoint = "kratos-external-idp"
  }

  application {
    name     = juju_application.kratos.name
    endpoint = "kratos-external-idp"
  }
}

resource "juju_integration" "kratos_identity_platform_login_ui_operator_kratos" {
  model = var.sso_juju_model_name

  application {
    name     = juju_application.identity_platform_login_ui_operator.name
    endpoint = "kratos-endpoint-info"
  }

  application {
    name     = juju_application.kratos.name
    endpoint = "kratos-endpoint-info"
  }
}

resource "juju_integration" "hydra_postgres" {
  model = var.sso_juju_model_name

  application {
    name     = juju_application.postgres.name
    endpoint = "database"
  }

  application {
    name     = juju_application.hydra.name
    endpoint = "pg-database"
  }
}

resource "juju_integration" "kratos_postgres" {
  model = var.sso_juju_model_name

  application {
    name     = juju_application.postgres.name
    endpoint = "database"
  }

  application {
    name     = juju_application.kratos.name
    endpoint = "pg-database"
  }
}

resource "juju_integration" "traefik_admin_certificates" {
  model = var.sso_juju_model_name

  application {
    name     = juju_application.traefik_admin.name
    endpoint = "certificates"
  }

  application {
    name = juju_application.self_signed_certificates.name
  }
}

resource "juju_integration" "hydra_traefik_admin" {
  model = var.sso_juju_model_name

  application {
    name     = juju_application.traefik_admin.name
    endpoint = "ingress"
  }

  application {
    name     = juju_application.hydra.name
    endpoint = "admin-ingress"
  }
}

resource "juju_integration" "kratos_traefik_admin" {
  model = var.sso_juju_model_name

  application {
    name     = juju_application.traefik_admin.name
    endpoint = "ingress"
  }

  application {
    name     = juju_application.kratos.name
    endpoint = "admin-ingress"
  }
}

resource "juju_integration" "hydra_traefik_public" {
  model = var.sso_juju_model_name

  application {
    name     = "traefik-public"
    endpoint = "ingress"
  }

  application {
    name     = juju_application.hydra.name
    endpoint = "public-ingress"
  }
}

resource "juju_integration" "kratos_traefik_public" {
  model = var.sso_juju_model_name

  application {
    name     = "traefik-public"
    endpoint = "ingress"
  }

  application {
    name     = juju_application.kratos.name
    endpoint = "public-ingress"
  }
}

resource "juju_integration" "identity_platform_login_ui_operator_traefik" {
  model = var.sso_juju_model_name

  application {
    name     = "traefik-public"
    endpoint = "ingress"
  }

  application {
    name     = juju_application.identity_platform_login_ui_operator.name
    endpoint = "ingress"
  }
}

# Should be deployed with image oryd/oathkeeper:v0.40.6
# The charm is not the same either
resource "juju_application" "oathkeeper" {
  name  = "oathkeeper"
  model = var.sso_juju_model_name

  charm {
    name     = "oathkeeper"
    channel  = "latest/edge"
    revision = 18
    series   = "jammy"
  }

  units = 1
}

# The identity team will also add the following relations, that are not supported yet.
# I'll be adding the commented out TF below

# juju relate oathkeeper:ingress traefik-public:ingress
# juju relate oathkeeper:forward-auth traefik-public:forward-auth
# juju relate zinc-k8s:ingress traefik-public:ingress
# juju relate oathkeeper:auth-proxy zinc-k8s:auth-proxy
# 
# resource "juju_integration" "oathkeeper_trafik_public_ingress" {
#   model = var.sso_juju_model_name
# 
#   application {
#     name     = juju_application.oathkeeper.name
#     endpoint = "ingress"
#   }
# 
#   application {
#     name     = "traefik-public"
#     endpoint = "ingress"
#   }
# }
# 
# resource "juju_integration" "oathkeeper_trafik_public_forward_auth" {
#   model = var.sso_juju_model_name
# 
#   application {
#     name     = juju_application.oathkeeper.name
#     endpoint = "forward-auth"
#   }
# 
#   application {
#     name     = "traefik-public"
#     endpoint = "forward-auth"
#   }
# }
# 
# resource "juju_integration" "zinc_trafik_public_ingress" {
#   model = var.sso_juju_model_name
# 
#   application {
#     name     = juju_application.oathkeeper.name
#     endpoint = "ingress"
#   }
# 
#   application {
#     name     = juju_application.zinc.name
#     endpoint = "ingress"
#   }
# }
# 
# resource "juju_integration" "oathkeeper_zinc_auth_proxy" {
#   model = var.sso_juju_model_name
# 
#   application {
#     name     = juju_application.oathkeeper.name
#     endpoint = "auth-proxy"
#   }
# 
#   application {
#     name     = juju_application.zinc.name
#     endpoint = "auth-proxy"
#   }
# }
# 
