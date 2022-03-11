variable "target_account_id" {
  description = "Account Id where the key would be used"
  type = string
}
variable "name" {
  type = string
  description = "Application/usage of the key"
}
variable "additional_permissions" {
  type = list(object(
    {
      name        = string
      account_ids = list(string)
      access = list(object(
        {
          identifiers = list(string)
          actions     = list(string)
          type        = string
      }))
  }))
  description = "Additional permissions, for cross account key access"
  default = []
}
variable "target_account_name" {
  type = string
  description = "Account name where the key would be used, it would added to all aliases"
}