# toolbox-aws-cognito
Terraform stack to create AWS cognito


# To start
1. Make sure you have created an aws hosted zone.
2. Make sure you have create an aws access key secret with sufficient permissions.

# Use
1. Add your custom data to `terraform.tfvars`
2. Run `terraform init`.
3. Run `terraform plan` to check what will be applied.
4. Run `terraform apply` to apply changes.
5. After step 3. You may run into error telling you your certificate is not available. Go to your AWS website and wait till they verify your new certificate. Once it's done, run `terraform apply` again.
6. To verify your Cognito page works, go to link `https://<your_user_pool_domain>/login?response_type=code&client_id=<your_client_id>&redirect_uri=https://www.example.com`, where you can find your client id from the terraform output, and your redirect uri from your variables. More details --> [link](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-social-idp.html). In my case, you can test if it works from `https://auth.monkeypatch.ca/login?response_type=token&client_id=aa6l7p0vm7ejkg38cdl04ed8s&redirect_uri=https%3A%2F%2Fmonkeypatch.ca`

# Todo
1. Upgrade to Terraform 0.13 for `depends_on` support to ensure other resources will wait till certificate is verified.
2. Examples to support other social idps.
3. Examples to support OIDC and SAML providers.