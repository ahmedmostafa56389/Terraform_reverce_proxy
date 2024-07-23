output  "pub_id" {
  value = aws_subnet.public_sub[*].id
}

output  "priv_id" {
  value = aws_subnet.private[*].id
}

output  "sec_group_a" {
  value = aws_security_group.apache_sg.id
}

output  "sec_group_n" {
  value = aws_security_group.nginx_sg.id
}


output "vpc_id"  {
  value = aws_vpc.vpc.id
}

