# toolbox-aws-cognito
Terraform stack to create AWS cognito


# To start
1. Make sure you have created an aws hosted zone.
2. Make sure you have create an aws access key secret with sufficient permissions.

# Use
1. Run `terraform init`.
2. Run `terraform plan` to check what will be applied.
3. Run `terraform apply` to apply changes.
4. After step 3. You may run into error telling you your certificate is not available. Go to your AWS website and wait till they verify your new certificate. Once it's done, run `terraform apply` again.

# Todo
1. Upgrade to Terraform 0.13 for `depends_on` support to ensure other resources will wait till certificate is verified.
2. Examples to support other social media type idps.
3. Examples to support OIDC and SAML providers.