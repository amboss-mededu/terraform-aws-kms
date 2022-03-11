## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_iam_policy_document.service_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_permissions"></a> [additional\_permissions](#input\_additional\_permissions) | ADditional permissions, for cross account key access | <pre>list(object(<br>    {<br>      name        = string<br>      account_ids = list(string)<br>      access = list(object(<br>        {<br>          identifiers = list(string)<br>          actions     = list(string)<br>          type        = string<br>      }))<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Application/usage of the key | `string` | n/a | yes |
| <a name="input_target_account_id"></a> [target\_account\_id](#input\_target\_account\_id) | Account Id where the key would be used | `string` | n/a | yes |
| <a name="input_target_account_name"></a> [target\_account\_name](#input\_target\_account\_name) | Account name where the key would be used, it would added to all aliases | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_key"></a> [kms\_key](#output\_kms\_key) | n/a |
