resource "aws_lb" "public" {
  name               = "public-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sec_group_a]
  subnets            = var.pub_subnet

}

resource "aws_lb" "private" {
  name               = "private-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sec_group_a]
  subnets            = var.priv_subnet

}

resource "aws_lb_target_group" "apache" {
  name     = "apache-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
}

resource "aws_lb_target_group" "nginx" {
  name     = "nginx-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
}

resource "aws_lb_listener" "public" {
  load_balancer_arn = aws_lb.public.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }
}

resource "aws_lb_listener" "private" {
  load_balancer_arn = aws_lb.private.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.apache.arn
  }
}


resource "aws_lb_target_group_attachment" "a_attach" {
  count            = 2
  target_group_arn = aws_lb_target_group.apache.arn
  target_id        = var.apache_ids[count.index]
  port             = 80
}

resource "aws_lb_target_group_attachment" "n_attach" {
  count            = 2
  target_group_arn = aws_lb_target_group.nginx.arn
  target_id        = var.nginx_ids[count.index]
  port             = 80
}

