resource "aws_s3_bucket" "in" {
  bucket = var.in_bucket

  tags = {
    Name = var.in_bucket
  }
}

resource "aws_s3_bucket_acl" "in_acl" {
  bucket = aws_s3_bucket.in.id
  acl    = "private"
}

resource "aws_s3_bucket" "out" {
  bucket = var.out_bucket

  tags = {
    Name = var.out_bucket
  }
}

resource "aws_s3_bucket_acl" "out_acl" {
  bucket = aws_s3_bucket.out.id
  acl    = "private"
}
