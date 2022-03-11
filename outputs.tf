output "key" {
  value       = aws_kms_key.key
  description = "Key id and arn map"
}
output "alias" {
  value       = aws_kms_alias.alias
  description = "Alias id/arn and key id/arn map"
}