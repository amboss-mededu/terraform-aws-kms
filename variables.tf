variable "target_account_id" {
  type = string
}
variable "name" {
  type = string
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
  default = []
}
variable "target_account_name" {
  type = string
}