output "private_instance_ids" {
  value = aws_instance.my_instance_private[*].id
}