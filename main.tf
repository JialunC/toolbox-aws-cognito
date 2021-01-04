provider "aws" {
  region  = var.region
  profile = var.profile
}

resource "aws_cognito_user_pool_domain" "main" {
  domain          = var.cognito_pool_domain
  certificate_arn = aws_acm_certificate.cert.arn
  user_pool_id    = aws_cognito_user_pool.user_pool.id
}

resource "aws_cognito_user_pool" "user_pool" {
  name = var.user_pool_name
}

resource "aws_acm_certificate" "cert" {
  domain_name       = var.certificate_domain
  validation_method = "DNS"

  tags = {
    Environment = "test"
    Name        = "google-auth"
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "host_zone" {
  name = var.domain_name
}

resource "aws_route53_record" "a-record" {
  zone_id = data.aws_route53_zone.host_zone.zone_id
  name    = aws_cognito_user_pool_domain.main.domain
  type    = "A"

  alias {
    evaluate_target_health = false
    name                   = aws_cognito_user_pool_domain.main.cloudfront_distribution_arn
    zone_id                = "Z2FDTNDATAQYW2"
  }
}

resource "aws_cognito_user_pool_client" "cognito_client" {
  name                                 = var.name
  user_pool_id                         = aws_cognito_user_pool.user_pool.id
  supported_identity_providers         = ["Google"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["implicit"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  callback_urls                        = var.client_callback_urls
  generate_secret                      = true
  explicit_auth_flows                  = []
}

resource "aws_cognito_identity_provider" "idp_google_social" {
  user_pool_id  = aws_cognito_user_pool.user_pool.id
  provider_name = "Google"
  provider_type = "Google"

  provider_details = {
    authorize_scopes = "profile email openid"
    client_id        = local.google_client_creds.client_id
    client_secret    = local.google_client_creds.client_secret
  }

  attribute_mapping = {
    email    = "email"
    username = "sub"
  }
}

data "aws_secretsmanager_secret" "secrets" {
  arn = var.google_client_ssm_id
}

data "aws_secretsmanager_secret_version" "google_client_creds" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}
