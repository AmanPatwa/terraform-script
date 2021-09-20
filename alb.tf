module "alb" {
  source  = "terraform-aws-modules/alb/aws"
#   version = "~> 6.0"

  name = "group3-alb"

  load_balancer_type = "application"

  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets
  security_groups    = [aws_security_group.allow_tls.id]

#   access_logs = {
#     bucket = "group3-alb-logs"
#   }

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 8000
      target_type      = "instance"
    #   targets = [
    #     {
    #       target_id = "i-0123456789abcdefg"
    #       port = 80
    #     },
    #     {
    #       target_id = "i-a1b2c3d4e5f6g7h8i"
    #       port = 8080
    #     }
    #   ]
    }
  ]

#   https_listeners = [
#     {
#       port               = 443
#       protocol           = "HTTPS"
#       certificate_arn    = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
#       target_group_index = 0
#     }
#   ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "Test"
  }

  depends_on = [
    module.vpc
  ]
}