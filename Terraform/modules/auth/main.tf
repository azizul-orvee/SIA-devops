resource "aws_cognito_user_pool" "main" {
  name = "my_user_pool"

  auto_verified_attributes = ["email"]
  email_verification_message = "Scopic Software DevOps task verification code is {####}."

    schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }
  
  password_policy {
    minimum_length    = 8
    require_lowercase = false
    require_numbers   = true
    require_symbols   = false
    require_uppercase = false
  }

  username_configuration {
    case_sensitive = false
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name = "my_user_pool_client"

  user_pool_id = aws_cognito_user_pool.main.id

  explicit_auth_flows = [
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
  ]
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "scopic-devops889966"
  user_pool_id = aws_cognito_user_pool.main.id
}


output "USER_POOL_APP_CLIENT_ID" {
  description = "The ID of the App Client"
  value       = aws_cognito_user_pool_client.client.id
  sensitive   = true
}

output "USER_POOL_ID" {
  description = "The ID of the User Pool"
  value       = aws_cognito_user_pool.main.id
  sensitive   = true
}

output "REGION" {
  description = "AWS Region"
  value       = "us-east-1"
  sensitive   = true
}

# terraform output -json > output.json
