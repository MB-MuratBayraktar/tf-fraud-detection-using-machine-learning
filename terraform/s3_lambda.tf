resource "aws_s3_bucket" "frauddetectionfunctionbucket" {
  bucket = "${var.function_bucket_name}-${var.aws_region}"

  tags = {
    Description = "Bucket hosting the code for fraud_detection Lambda function."
    Group       = var.default_resource_group
    CreatedBy   = var.default_created_by
  }
}


data "archive_file" "fraud_detection_archive" {
  type        = "zip"
  source_file = "${path.module}/../source/fraud_detection/index.py"
  output_path = "${path.module}/../dist/fraud_detection.zip"
}

resource "aws_s3_bucket_acl" "fraud_detection_function_bucket_acl" {
  bucket = aws_s3_bucket.frauddetectionfunctionbucket.id
  acl = "private"
}


resource "aws_s3_object" "s3_fraud_detection_archive" {
  bucket = aws_s3_bucket.frauddetectionfunctionbucket.id
  key    = "fraud-detection-using-machine-learning/${var.function_version}/fraud_detection.zip"
  source = data.archive_file.fraud_detection_archive.output_path

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(data.archive_file.fraud_detection_archive.output_path) # use md5 of index.py to detect changes in the function
}
