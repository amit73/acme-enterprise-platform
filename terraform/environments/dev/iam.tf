resource "aws_iam_role" "web_role" {
  name = "acme-web-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "s3_list_policy" {
  name        = "acme-s3-list-policy"
  description = "Allow listing S3 buckets"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:ListAllMyBuckets"
        ]

        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "web_role_s3_policy" {
  role       = aws_iam_role.web_role.name
  policy_arn = aws_iam_policy.s3_list_policy.arn
}

resource "aws_iam_instance_profile" "web_profile" {
  name = "acme-web-profile"
  role = aws_iam_role.web_role.name
}