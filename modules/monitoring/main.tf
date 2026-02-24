locals {
  alarm_actions = var.sns_topic_arn == null ? [] : [var.sns_topic_arn]
}

# ALB TG alarms
resource "aws_cloudwatch_metric_alarm" "tg_unhealthy_hosts" {
  alarm_name          = "${var.name}-tg-unhealthy-hosts"
  alarm_description   = "Target group has unhealthy targets"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  period              = 60
  threshold           = 0
  statistic           = "Maximum"
  treat_missing_data  = "notBreaching"

  namespace   = "AWS/ApplicationELB"
  metric_name = "UnHealthyHostCount"

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
    TargetGroup  = var.target_group_arn_suffix
  }

  alarm_actions = local.alarm_actions
  ok_actions    = local.alarm_actions
}
resource "aws_cloudwatch_metric_alarm" "tg_5xx" {
  alarm_name          = "${var.name}-tg-5xx"
  alarm_description   = "Target group is returning 5XX errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  period              = 60
  threshold           = 0
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"

  namespace   = "AWS/ApplicationELB"
  metric_name = "HTTPCode_Target_5XX_Count"

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
    TargetGroup  = var.target_group_arn_suffix
  }

  alarm_actions = local.alarm_actions
  ok_actions    = local.alarm_actions
}
resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
  alarm_name          = "${var.name}-alb-5xx"
  alarm_description   = "ALB is returning 5XX errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  period              = 60
  threshold           = 0
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"

  namespace   = "AWS/ApplicationELB"
  metric_name = "HTTPCode_ELB_5XX_Count"

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
  }

  alarm_actions = local.alarm_actions
  ok_actions    = local.alarm_actions
}
resource "aws_cloudwatch_metric_alarm" "tg_latency" {
  alarm_name          = "${var.name}-tg-latency-high"
  alarm_description   = "Target response time is high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3
  period              = 60
  threshold           = 1
  statistic           = "Average"
  treat_missing_data  = "notBreaching"

  namespace   = "AWS/ApplicationELB"
  metric_name = "TargetResponseTime"

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
    TargetGroup  = var.target_group_arn_suffix
  }

  alarm_actions = local.alarm_actions
  ok_actions    = local.alarm_actions
}

resource "aws_cloudwatch_metric_alarm" "asg_in_service_low" {
  alarm_name          = "${var.name}-asg-inservice-low"
  alarm_description   = "ASG has fewer InService instances than expected"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  period              = 60
  threshold           = var.min_size
  statistic           = "Minimum"
  treat_missing_data  = "breaching"

  namespace   = "AWS/AutoScaling"
  metric_name = "GroupInServiceInstances"

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }

  alarm_actions = local.alarm_actions
  ok_actions    = local.alarm_actions
}