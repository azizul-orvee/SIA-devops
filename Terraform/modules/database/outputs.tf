output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.default.endpoint
}

output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.default.address
}

output "rds_username" {
  description = "Username for the RDS instance"
  value       = aws_db_instance.default.username
}

output "rds_password" {
  description = "Username for the RDS instance"
  value       = aws_db_instance.default.password
  sensitive = true
}
