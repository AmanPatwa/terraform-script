# module "asg" {
#   source  = "terraform-aws-modules/autoscaling/aws"
# #   version = "~> 4.0"

#   # Autoscaling group
#   name = "group3-asg-1"

#   min_size                  = 2
#   max_size                  = 4
#   desired_capacity          = 2
#   wait_for_capacity_timeout = 0
#   health_check_type         = "EC2"
#   vpc_zone_identifier       = module.vpc.private_subnets

#   initial_lifecycle_hooks = [
#     {
#       name                  = "ExampleStartupLifeCycleHook"
#       default_result        = "CONTINUE"
#       heartbeat_timeout     = 60
#       lifecycle_transition  = "autoscaling:EC2_INSTANCE_LAUNCHING"
#       notification_metadata = jsonencode({ "hello" = "world" })
#     },
#     {
#       name                  = "ExampleTerminationLifeCycleHook"
#       default_result        = "CONTINUE"
#       heartbeat_timeout     = 180
#       lifecycle_transition  = "autoscaling:EC2_INSTANCE_TERMINATING"
#       notification_metadata = jsonencode({ "goodbye" = "world" })
#     }
#   ]

#   instance_refresh = {
#     strategy = "Rolling"
#     preferences = {
#       min_healthy_percentage = 50
#     }
#     triggers = ["tag"]
#   }

#   # Launch template
#   lt_name                = "group3-new-template"
#   description            = "Launch template example"
#   update_default_version = true

#   use_lt    = true
#   create_lt = true

#   image_id          = "ami-08dbf16d54b8c4173"
#   instance_type     = "t2.micro"
# #   ebs_optimized     = true
#   enable_monitoring = true

#   security_groups = [aws_security_group.allow_tls1.id]

#   target_group_arns = module.alb.target_group_arns

# #   block_device_mappings = [
# #     {
# #       # Root volume
# #       device_name = "/dev/xvda"
# #       no_device   = 0
# #       ebs = {
# #         delete_on_termination = true
# #         encrypted             = true
# #         volume_size           = 20
# #         volume_type           = "gp2"
# #       }
# #       }
# #     # {
# #     #   device_name = "/dev/sda1"
# #     #   no_device   = 1
# #     #   ebs = {
# #     #     delete_on_termination = true
# #     #     encrypted             = true
# #     #     volume_size           = 30
# #     #     volume_type           = "gp2"
# #     #   }
# #     # }
# #   ]

# #   capacity_reservation_specification = {
# #     capacity_reservation_preference = "open"
# #   }

# #   cpu_options = {
# #     core_count       = 1
# #     threads_per_core = 1
# #   }

# #   credit_specification = {
# #     cpu_credits = "standard"
# #   }

# #   instance_market_options = {
# #     market_type = "spot"
# #     spot_options = {
# #       block_duration_minutes = 60
# #     }
# #   }

# #   metadata_options = {
# #     http_endpoint               = "enabled"
# #     http_tokens                 = "required"
# #     http_put_response_hop_limit = 32
# #     # user_data = "#!/bin/bash\nsudo apt update\ncd /home/ubuntu/Exam-Portal/\nsource /home/ubuntu/Exam-Portal/devenv/bin/activate\ncd /home/ubuntu/Exam-Portal/Exam/\npython manage.py makemigrations\npython manage.py migrate\npython manage.py runserver 0.0.0.0:8000"
# #   }

# #   user_data_base64 = "#!/bin/bash\nsudo apt update\ncd /home/ubuntu/Exam-Portal/\nsource /home/ubuntu/Exam-Portal/devenv/bin/activate\ncd /home/ubuntu/Exam-Portal/Exam/\npython manage.py makemigrations\npython manage.py migrate\npython manage.py runserver 0.0.0.0:8000"

#   user_data_base64 = "IyEvYmluL2Jhc2hcbnN1ZG8gYXB0IHVwZGF0ZVxuY2QgL2hvbWUvdWJ1bnR1L0V4YW0tUG9ydGFsL1xuc291cmNlIC9ob21lL3VidW50dS9FeGFtLVBvcnRhbC9kZXZlbnYvYmluL2FjdGl2YXRlXG5jZCAvaG9tZS91YnVudHUvRXhhbS1Qb3J0YWwvRXhhbS9cbnB5dGhvbiBtYW5hZ2UucHkgbWFrZW1pZ3JhdGlvbnNcbnB5dGhvbiBtYW5hZ2UucHkgbWlncmF0ZVxucHl0aG9uIG1hbmFnZS5weSBydW5zZXJ2ZXIgMC4wLjAuMDo4MDAw"

# #   network_interfaces = [
# #     {
# #       delete_on_termination = true
# #       description           = "eth0"
# #       device_index          = 0
# #       security_groups       = [aws_security_group.allow_tls1.id]
# #     }
# #     # {
# #     #   delete_on_termination = true
# #     #   description           = "eth1"
# #     #   device_index          = 1
# #     #   security_groups       = ["sg-12345678"]
# #     # }
# #   ]

# #   placement = {
# #     availability_zone = "us-west-1b"
# #   }

# #   tag_specifications = [
# #     {
# #       resource_type = "instance"
# #       tags          = { WhatAmI = "Instance" }
# #     },
# #     {
# #       resource_type = "volume"
# #       tags          = { WhatAmI = "Volume" }
# #     }
# #   ]

#   tags = [
#     {
#       key                 = "Environment"
#       value               = "dev"
#       propagate_at_launch = true
#     },
#     {
#       key                 = "Project"
#       value               = "megasecret"
#       propagate_at_launch = true
#     },
#   ]

# #   tags_as_map = {
# #     extra_tag1 = "extra_value1"
# #     extra_tag2 = "extra_value2"
# #   }

#   depends_on = [
#     module.alb,
#     module.vpc
#   ]
# }

