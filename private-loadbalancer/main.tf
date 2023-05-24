resource "aws_lb" "private-loadbalancer" {
  name               = var.lb_name
  internal           = true
  load_balancer_type = var.lb_type
  security_groups    = var.lb_security_gps
  subnets            = var.lb_subnets
}
resource "aws_lb_target_group" "private_target_group" {
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
  count            = length(var.private_instance_ids)
  target_group_arn = aws_lb_target_group.private_target_group.arn
  target_id        = var.private_instance_ids[count.index]
  port             = var.port
}

resource "aws_lb_listener" "private-listener" {
  load_balancer_arn = aws_lb.private-loadbalancer.arn
  port              = var.port
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_target_group.arn
  }
}
