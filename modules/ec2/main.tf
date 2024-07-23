resource "aws_instance" "apache" {
  count                  = length(var.pub_subnet)
  ami                    = var.apache_ami
  #ami                    = "ami-04a81a99f5ec58529" 
  instance_type          = "t2.micro"
  subnet_id              = var.pub_subnet[count.index]
  security_groups        = [var.sec_group_a]
  associate_public_ip_address = true
  
  user_data     = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
systemctl restart apache2
                  EOF

  tags = {
    Name = "web-server"
  }
}


resource "aws_instance" "nginx" {
  count                  = length(var.priv_subnet)
  ami                    = var.apache_ami
  #ami                    = "ami-04a81a99f5ec58529"
  instance_type          = "t2.micro"
  subnet_id              = var.priv_subnet[count.index]
  security_groups        = [var.sec_group_n]
  #!/bin/bash
   user_data     = <<EOF

sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo cat > /etc/nginx/sites-enabled/default << EOL
server {
    listen 80 default_server;
    location / {
      proxy_pass http://${var.priv_lb_dns};
    }
}
  
EOL
sudo systemctl restart nginx
  EOF


  tags = {
    Name = "nginx-server"
  }
}

