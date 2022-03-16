output "key" {
  description = "Key id and arn map"
  value = {
    id  = try(aws_kms_key.key[0].id,"")
    arn = try(aws_kms_key.key[0].arn,"")
  }
}
output "alias" {
  description = "Alias id/arn and key id/arn map"
  value = {
    id  = try(aws_kms_alias.alias[0].id,"")
    arn = try(aws_kms_alias.alias[0].arn,"")
  }
}