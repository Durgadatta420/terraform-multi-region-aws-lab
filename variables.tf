
variable "mumbai_region" {
  description = "AWS Mumbai region"
  type        = string
  default     = "ap-south-1"
}

variable "virginia_region" {
  description = "AWS Virginia region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
}
