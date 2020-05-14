
resource "aws_cloudwatch_metric_alarm" "instance-health-check" {
  count               = length(var.instance_id_lst)
  alarm_name          = var.instance_name[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "This metric monitors ec2 health status"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]

  dimensions = {
    InstanceId = var.instance_id_lst[count.index]
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu-utilization" {
  count               = length(var.instance_id_lst)
  alarm_name          = "high-cpu-utilization-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu utilization"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]

  dimensions = {
    InstanceId = var.instance_id_lst[count.index]
  }
}