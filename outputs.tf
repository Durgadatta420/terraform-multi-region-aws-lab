output "mumbai_instance_id" {
  value = aws_instance.mumbai_ec2.id
}

output "virginia_instance_id" {
  value = aws_instance.virginia_ec2.id
}

output "s3_bucket_name" {
  value = aws_s3_bucket.lab_bucket.bucket
}