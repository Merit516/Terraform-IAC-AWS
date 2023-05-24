resource "aws_lb" "public-loadbalancer" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = var.lb_type
  security_groups    = var.lb_security_gps
  subnets            = var.lb_subnets
  tags = {
    "Name" = "public-loadbalancer"
  }
  provisioner "local-exec" {
    command = "echo ${aws_lb.public-loadbalancer.dns_name} > public-loadbalancer-dns.txt"
  }

}
resource "aws_lb_target_group" "public_target_group" {
  name     = var.tg_name
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id
  health_check {
        interval            = 30
        path                = "/"
        port                = var.port
        protocol            = var.protocol
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
  }

}

resource "aws_lb_target_group_attachment" "target_gp_attach" {
  count            = length(var.public_instance_ids)
  target_group_arn = aws_lb_target_group.public_target_group.arn
  target_id        = var.public_instance_ids[count.index]
  port             = var.port
}

resource "aws_lb_listener" "public-listener" {
  load_balancer_arn = aws_lb.public-loadbalancer.arn
  port              = var.port
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_target_group.arn
  }
}