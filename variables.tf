# aws region to create this project
variable "region" {
  type = string
}
# aws profile, need to match secrets stored in ~/.aws/credentials
variable "profile" {
  type = string
}
# domain name is used to find your hosted zone 
variable "domain_name" {
  type = string
}
variable "certificate_domain" {
  type = string
}
# custom domain used for hosting cognito
variable "cognito_pool_domain" {
  type = string
}
# name for user pool name
variable "user_pool_name" {
  type = string
}
# callback urls
variable "client_callback_urls" {
  type = list(string)
}
# cognito client name
variable "name" {
  type = string
}
# google client secrets manager secret id, region has to match aws region
variable "google_client_ssm_id" {
  type = string
}

locals {
  google_client_creds = jsondecode(
    data.aws_secretsmanager_secret_version.google_client_creds.secret_string
  )
}
