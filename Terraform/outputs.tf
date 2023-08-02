// Outputs from auth module
# output "USER_POOL_APP_CLIENT_ID" {
#   description = "The ID of the App Client"
#   value       = module.auth.USER_POOL_APP_CLIENT_ID
#   sensitive   = true
# }

# output "USER_POOL_ID" {
#   description = "The ID of the User Pool"
#   value       = module.auth.USER_POOL_ID
#   sensitive   = true
# }

# output "REGION" {
#   description = "AWS Region"
#   value       = module.auth.REGION
#   sensitive   = true
# }

// Outputs from frontend module
# output "frontend_bucket_name" {
#   description = "The name of the frontend bucket"
#   value       = module.frontend.bucket_name
# }

# output "frontend_cloudfront_distribution_id" {
#   description = "The ID of the frontend CloudFront distribution"
#   value       = module.frontend.cloudfront_distribution_id
# }

# output "frontend_cloudfront_distribution_domain_name" {
#   description = "The domain name of the frontend CloudFront distribution"
#   value       = module.frontend.cloudfront_distribution_domain_name
# }



// Outputs from backend module
// output "BACKEND_OUTPUT" {
//   description = "Description here"
//   value       = module.backend.BACKEND_OUTPUT
//   sensitive   = false
// }

// Outputs from database module
# output "rds_endpoint" {
#   description = "The connection endpoint for the RDS instance"
#   value       = module.database.rds_endpoint
# }

# output "rds_username" {
#   description = "Username for the RDS instance"
#   value       = module.database.rds_username
# }

# output "rds_hostname" {
#   description = "RDS instance hostname"
#   value       = module.database.rds_hostname
# }

