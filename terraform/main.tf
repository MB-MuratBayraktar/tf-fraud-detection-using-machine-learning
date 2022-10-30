provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

provider "template" {
#  version = "~> 2.1"
}

provider "archive" {
#  version = "~> 1.2"
}

data "aws_caller_identity" "current" {}
