resource "aws_launch_template" "foo" {
  name = "group3-launch-template-1"

  iam_instance_profile {
    name = "PE-Training-2021"
  }

  image_id = "ami-08dbf16d54b8c4173"

  instance_type = "t2.micro"

#   kernel_id = "test"

  key_name = "group3"

#   license_specification {
#     license_configuration_arn = "arn:aws:license-manager:eu-west-1:123456789012:license-configuration:lic-0123456789abcdef0123456789abcdef"
#   }

#   metadata_options {
#     http_endpoint               = "enabled"
#     http_tokens                 = "required"
#     http_put_response_hop_limit = 1
#   }

#   monitoring {
#     enabled = true
#   }

#   network_interfaces {
#     associate_public_ip_address = true
#   }

#   placement {
#     availability_zone = "us-west-2a"
#   }

#   ram_disk_id = "test"

  vpc_security_group_ids = [aws_security_group.allow_tls1.id]

#   tag_specifications {
#     resource_type = "instance"

#     tags = {
#       Name = "test"
#     }
#   }

  user_data = "IyEvYmluL2Jhc2hcbnN1ZG8gYXB0IHVwZGF0ZVxuY2QgL2hvbWUvdWJ1bnR1L0V4YW0tUG9ydGFsL1xuc291cmNlIC9ob21lL3VidW50dS9FeGFtLVBvcnRhbC9kZXZlbnYvYmluL2FjdGl2YXRlXG5jZCAvaG9tZS91YnVudHUvRXhhbS1Qb3J0YWwvRXhhbS9cbnB5dGhvbiBtYW5hZ2UucHkgbWFrZW1pZ3JhdGlvbnNcbnB5dGhvbiBtYW5hZ2UucHkgbWlncmF0ZVxucHl0aG9uIG1hbmFnZS5weSBydW5zZXJ2ZXIgMC4wLjAuMDo4MDAw"
}

# resource "aws_autoscaling_group" "bar" {
#   availability_zones = ["us-east-1a","us-east-1b"]
#   desired_capacity   = 2
#   max_size           = 4
#   min_size           = 2
#   health_check_grace_period = 300
#   health_check_type         = "EC2"

#   launch_template {
#     id      = aws_launch_template.foo.id
#     version = "$Latest"
#   }
#   vpc_zone_identifier       = module.vpc.private_subnets
# }

resource "aws_autoscaling_group" "Group3-asg" {
  name                      = "group3-asg-2"
  max_size                  = 4
  min_size                  = 2
  launch_template {
    id      = aws_launch_template.foo.id
    version = "$Latest"
  }
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 2
  vpc_zone_identifier       = module.vpc.private_subnets
  target_group_arns         = module.alb.target_group_arns
  metrics_granularity       = "1Minute"
  enabled_metrics           = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  wait_for_capacity_timeout = "10m"
#   tags = [
#     {
#       key                 = "Name"
#       value               = "${var.name_preffix}_asg"
#       propagate_at_launch = true
#     },
#   ]

  depends_on = [
    module.vpc,
    module.alb
  ]
}

#------------------------------------------------------------------------------
# AUTOSCALING POLICIES
#------------------------------------------------------------------------------
# Scaling UP - CPU High
resource "aws_autoscaling_policy" "Group3-cpu_high" {
  name                   = "group3-cpu-high"
  autoscaling_group_name = aws_autoscaling_group.Group3-asg.name
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "SimpleScaling"
  scaling_adjustment     = "1"
  cooldown               = "300"
}
# Scaling DOWN - CPU Low
resource "aws_autoscaling_policy" "Group3-cpu_low" {
  name                   = "group3-cpu-high"
  autoscaling_group_name = aws_autoscaling_group.Group3-asg.name
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "SimpleScaling"
  scaling_adjustment     = "-1"
  cooldown               = "300"
}

#------------------------------------------------------------------------------
# CLOUDWATCH METRIC ALARMS
#------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "Group3-cpu_high_alarm" {
  alarm_name          = "group3-cpu-high-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  actions_enabled     = true
  alarm_actions       = ["${aws_autoscaling_policy.Group3-cpu_high.arn}"]
  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.Group3-asg.name}"
  }
}
resource "aws_cloudwatch_metric_alarm" "Group3-cpu_low_alarm" {
  alarm_name          = "group3-cpu-low-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"
  actions_enabled     = true
  alarm_actions       = ["${aws_autoscaling_policy.Group3-cpu_low.arn}"]
  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.Group3-asg.name}"
  }
}


