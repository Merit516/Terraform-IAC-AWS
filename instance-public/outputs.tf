output "public_instance_ids" {
  value = aws_instance.my_instance_public[*].id
}