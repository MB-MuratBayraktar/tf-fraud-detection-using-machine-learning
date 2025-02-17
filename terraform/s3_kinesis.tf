resource "aws_s3_bucket" "s3bucket2" {
  bucket        = "${var.s3_bucket_name_2}-${var.aws_region}"
  force_destroy = true                                        # delete all data from this bucket before destroy

  tags = {
    Description = "Bucket for storing processed events for visualization features."
    Group       = "${var.default_resource_group}"
    CreatedBy   = "${var.default_created_by}"
  }
}

resource "aws_s3_bucket_acl" "s3bucket2acl" {
  bucket = aws_s3_bucket.s3bucket2.id
  acl="private"
}