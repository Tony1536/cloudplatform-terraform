resource "aws_lb" "cloudplatform_alb" {
  name            = var.alb_tag_name
  internal        = false
  security_groups = [var.alb_sg_id]
  subnets         = var.public_subnet_ids
  load_balancer_type = "application"

tags = {
    Name = var.alb_tag_name
}

}

resource "aws_lb_target_group" "cloudplatform_target_group" {
  name     = "${var.alb_tag_name}-tg"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
  
tags = {
    Name = "${var.alb_tag_name}-tg"
}
}

resource "aws_lb_listener" "cloudplatform_listener" {
  load_balancer_arn = aws_lb.cloudplatform_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cloudplatform_target_group.arn
  }
}