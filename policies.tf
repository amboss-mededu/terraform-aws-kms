data "aws_iam_policy_document" "kms_use" {
  statement {
    sid    = "Allow KMS key for Use"
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = [aws_kms_key.key[0].arn]
  }
}
resource "aws_iam_policy" "kms_use" {
  name     = "${var.target_account_name}-${var.name}-kms-use"
  policy   = data.aws_iam_policy_document.kms_use.json
  provider = aws.target
}
data "aws_iam_policy_document" "kms_use_with_grant" {
  statement {
    sid    = "Allow KMS key for Usage and subgrants"
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
      "kms:CreateGrant",
      "kms:RevokeGrant"
    ]
    resources = [aws_kms_key.key[0].arn]
  }
}
resource "aws_iam_policy" "kms_use_with_grant" {
  name     = "${var.target_account_name}-${var.name}-kms-use-with-grant"
  policy   = data.aws_iam_policy_document.kms_use_with_grant.json
  provider = aws.target
}
data "aws_iam_policy_document" "kms_decrypt" {
  statement {
    sid    = "Allow KMS key for Decryption"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
    ]
    resources = [aws_kms_key.key[0].arn]
  }
}
resource "aws_iam_policy" "kms_decrypt" {
  name     = "${var.target_account_name}-${var.name}-kms-decrypt"
  policy   = data.aws_iam_policy_document.kms_decrypt.json
  provider = aws.target
}