# SG-ALB
resource "aws_security_group" "sg_alb" {
 name         = var.alb_sg_name
 description  = var.alb_sg_description
 vpc_id       = var.vpc_id

tags = {
  Name        = var.alb_sg_name
}
}
resource "aws_security_group_rule" "alb_sg_http" {
    type              = "ingress"
    security_group_id = aws_security_group.sg_alb.id
    protocol          = "tcp"
    from_port         = 80
    to_port           = 80
    cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_sg_https" {
    type              = "ingress"
    security_group_id = aws_security_group.sg_alb.id
    protocol          = "tcp"
    from_port         = 443
    to_port           = 443
    cidr_blocks       = ["0.0.0.0/0"]
}


# SG-APP
resource "aws_security_group" "sg_app" {
    name           = var.app_sg_name
    description    = var.app_sg_description
    vpc_id         = var.vpc_id

    tags = {
        Name = var.app_sg_name
    }
}
resource "aws_security_group_rule" "app_from_alb" { 
    type                     = "ingress"
    security_group_id        = aws_security_group.sg_app.id
    protocol                 = "tcp"
    from_port                = var.app_port
    to_port                  = var.app_port
    source_security_group_id = aws_security_group.sg_alb.id
}
resource "aws_security_group_rule" "app_all_out" {
    type               = "egress"
    security_group_id  = aws_security_group.sg_app.id
    protocol           = "-1"
    from_port          = 0
    to_port            = 0
    cidr_blocks        = ["0.0.0.0/0"]
}

