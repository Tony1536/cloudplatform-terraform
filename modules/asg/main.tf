# Launch Template
resource "aws_launch_template" "cloudplatform_lt" {
  name_prefix   = "${var.name}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  dynamic "iam_instance_profile" {
    for_each = var.iam_instance_profile_name == null ? [] : [1]
    content {
        name = var.iam_instance_profile_name
    }
    
  }

  vpc_security_group_ids = [var.instance_sg_id]

  user_data = var.user_data == null ? null : base64encode(var.user_data)

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.name}-instance"
    }
    
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "cloudplatform_asg" {
  name                = "${var.name}-asg"
  vpc_zone_identifier = var.private_subnet_ids

  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size

  target_group_arns = [var.target_group_arn]

  health_check_type         = "ELB"
  health_check_grace_period = 120

  launch_template {
    id      = aws_launch_template.cloudplatform_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.name}-asg"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

