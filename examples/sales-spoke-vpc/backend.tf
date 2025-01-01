terraform {
  backend "s3" {
    bucket         = "${var.org}-s3-${var.app_id}-${var.environment}-tfstate"
    key            = "sales-spoke-vpc/tofu.tfstate"
    dynamodb_table = "${var.org}-ddbtable-${var.app_id}-${var.environment}-tfstate"
    encrypt        = true
  }
}