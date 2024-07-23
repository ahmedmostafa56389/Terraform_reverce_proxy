output "apache_ids" {
  value = aws_instance.apache[*].id
}

output "nginx_ids" {
  value = aws_instance.nginx[*].id
}

