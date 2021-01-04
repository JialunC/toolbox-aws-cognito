# aws region to create this project
region = "us-east-1"
# aws profile, need to match secrets stored in ~/.aws/credentials
profile = "private"
# domain name is used to find your hosted zone 
domain_name = "monkeypatch.ca"
# custom domain used for hosting cognito
cognito_pool_domain = "auth.monkeypatch.ca"
# the domain name that your ssl cert will use
certificate_domain = "*.monkeypatch.ca"
# name for user pool name
user_pool_name = "monkeypatch_user_pool"
# cognito client name
name = "monkeypatch"
# callback urls
client_callback_urls = ["https://monkeypatch.ca"]
# google client secrets manager secret id, region has to match aws region
google_client_ssm_id = "arn:aws:secretsmanager:us-east-1:612455316784:secret:google-social-idp-UFaGU2"