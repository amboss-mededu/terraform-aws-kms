output "key" {
  description = "Key id and arn map"
  value = {
    id  = aws_kms_key.key.id
    arn = aws_kms_key.key.arn
  }
}
output "alias" {
  description = "Alias id/arn and key id/arn map"
  value = {
    id  = aws_kms_alias.alias.id
    arn = aws_kms_alias.alias.arn
  }
}