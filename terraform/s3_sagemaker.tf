resource "aws_s3_bucket" "s3_bucket_1" {
  bucket        = "${var.s3_bucket_name_1}-${var.aws_region}"

  force_destroy = true                                        # delete all data from this bucket before destroy

  tags = {
    Description = "Bucket for storing the Amazon SageMaker model and training data."
    Group       = "${var.default_resource_group}"
    CreatedBy   = "${var.default_created_by}"

  }
}

resource "aws_s3_bucket_acl" "s3_bucket_1_acl"
  {
          bucket = aws_s3_bucket.s3_bucket_1.id
          acl = private
  }

resource "aws_s3_bucket_acl" "s3_bucket_1_acl"
{
  bucket = aws_s3_bucket.s3_bucket_1.id
  acl=private
}

resource "aws_s3_bucket_object" "s3_fraud_detection_notebook" {
  bucket = aws_s3_bucket.fraud_detection_function_bucket.id
  key    = "fraud-detection-using-machine-learning/${var.function_version}/notebooks/sagemaker_fraud_detection.ipynb"
  source = "${path.module}/../source/notebooks/sagemaker_fraud_detection.ipynb"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${path.module}/../source/notebooks/sagemaker_fraud_detection.ipynb")
}
