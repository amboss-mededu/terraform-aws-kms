data "aws_caller_identity" "current" {
  count = var.create_key ? 1 : 0
}
data "aws_iam_policy_document" "key_policy" {
  count = var.create_key ? 1 : 0
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current[0].account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
  dynamic "statement" {
    for_each = var.target_account_id == data.aws_caller_identity.current[0].account_id ? [] : [0]
    content {
      effect = "Allow"
      principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${var.target_account_id}:root"]
      }
      actions = [
        "kms:Decrypt",
        "kms:Encrypt",
        "kms:ReEncryptTo",
        "kms:GenerateData*",
        "kms:ReEncryptFrom",
        "kms:RetireGrant",
        "kms:RevokeGrant",
        "kms:GenerateRandom",
        "kms:Verify",
        "kms:List*",
        "kms:Describe*",
        "kms:Sign",
        "kms:CreateGrant"
      ]
      resources = ["*"]
    }
  }
  dynamic "statement" {
    for_each = var.target_account_id == data.aws_caller_identity.current[0].account_id ? [] : [0]
    content {
      effect = "Deny"
      principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${data.aws_caller_identity.current[0].account_id}:root"]
      }
      actions   = ["kms:Encrypt", "kms:Decrypt", "kms:ReEncrypt*", "kms:GenerateDataKey*", "kms:Sign", "kms:Verify"]
      resources = ["*"]
    }
  }
  dynamic "statement" {
    for_each = [for access in var.additional_permissions : {
      identifiers = access.identifiers
      actions     = access.actions
      type        = access.type
    }]
    content {
      effect = "Allow"
      principals {
        type        = statement.value.type
        identifiers = statement.value.identifiers
      }
      actions   = statement.value.actions
      resources = ["*"]
    }
  }
}
resource "aws_kms_key" "key" {
  count                   = var.create_key ? 1 : 0
  enable_key_rotation     = true
  deletion_window_in_days = 30
  policy                  = data.aws_iam_policy_document.key_policy[0].json
}
resource "aws_kms_alias" "alias" {
  count         = var.create_key ? 1 : 0
  name          = "alias/${var.target_account_name}-${var.name}"
  target_key_id = aws_kms_key.key[0].id
}
