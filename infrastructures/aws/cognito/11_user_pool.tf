# refs https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool

resource "aws_cognito_user_pool" "sso-cognito-example-pool" {
  name = var.user_pool_name

  auto_verified_attributes = ["email"]


  # Attributes
  username_configuration {
    case_sensitive = "false"
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = "false"
    mutable                  = "true"
    name                     = "email"
    required                 = "true"

    string_attribute_constraints {
      max_length = "2048"
      min_length = "0"
    }
  }


  # Policies
  password_policy {
    minimum_length                   = "8"
    require_lowercase                = "true"
    require_numbers                  = "true"
    require_symbols                  = "true"
    require_uppercase                = "true"
    temporary_password_validity_days = "7"
  }


  # Enabling SMS and Software Token Multi-Factor Authentication
  mfa_configuration = "OFF"

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
  }


  # Using Account Recovery Setting
  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = "1"
    }

    recovery_mechanism {
      name     = "verified_phone_number"
      priority = "2"
    }
  }


  # Customize of Messages
  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }


  # Admin Create User Config
  admin_create_user_config {
    allow_admin_create_user_only = "false"
  }
}


resource "aws_cognito_user_pool_client" "sso-example-pool-client" {
  name = var.user_pool_client_name
  user_pool_id = aws_cognito_user_pool.sso-cognito-example-pool.id

  # Flows
  generate_secret = true

  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH"
  ]


  # Security
  prevent_user_existence_errors = "ENABLED"


  # Client settings
  supported_identity_providers = [
    "COGNITO"
  ]

  callback_urls = var.callback_urls

  logout_urls = var.logout_urls

  allowed_oauth_flows_user_pool_client = true

  allowed_oauth_flows = [
    "code",     # Authorization code grant
    "implicit"  # Implicit grant
  ]

  allowed_oauth_scopes = [
    "phone",
    "email",
    "openid",
    "aws.cognito.signin.user.admin",
    "profile",
  ]
}


resource "aws_cognito_user_pool_domain" "sso-example-pool-domain" {
  domain = var.user_pool_domain_name
  user_pool_id = aws_cognito_user_pool.sso-cognito-example-pool.id
}


output "cognito_client_id" {
  value = aws_cognito_user_pool_client.sso-example-pool-client.id
}

output "cognito_client_secret" {
  value = aws_cognito_user_pool_client.sso-example-pool-client.client_secret
}

output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.sso-cognito-example-pool.id
}
