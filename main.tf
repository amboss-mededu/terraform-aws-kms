data "aws_iam_policy_document" "service_access" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id}:root"]
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
      "kms:CreateGrant",
    ]
    resources = ["*"]
  }
  statement {
    effect = "Deny"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.security_account_id}:root"]
    }
    actions   = ["kms:Encrypt", "kms:Decrypt", "kms:ReEncrypt*", "kms:GenerateDataKey*","kms:Sign", "kms:Verify"]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.security_account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
  dynamic "statement" {
    for_each = [for access in var.additional_permssions : {
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
  enable_key_rotation     = true
  deletion_window_in_days = 30
  policy                  = data.aws_iam_policy_document.service_access.json
}
resource "aws_kms_alias" "alias" {
  name          = "alias/${var.name}"
  target_key_id = aws_kms_key.key.id
}
