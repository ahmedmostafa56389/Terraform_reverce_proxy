output "pub_lb_dns" {
  value = aws_lb.public.dns_name
}

output "priv_lb_dns" {
  value = aws_lb.private.dns_name
}

