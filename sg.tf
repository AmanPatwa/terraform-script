resource "aws_security_group" "allow_tls" {
  name        = "group3-alb-sg-1"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

#   ingress = [
#     {
#       description      = "TLS from VPC"
#       from_port        = 80
#       to_port          = 80
#       protocol         = "tcp"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
#     }
#   ]

#   egress = [
#     {
#       from_port        = 0
#       to_port          = 0
#       protocol         = "-1"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
#     }
#   ]

#   tags = {
#     Name = "allow_tls"
#   }

  depends_on = [
    module.vpc
  ]
}

resource "aws_security_group" "allow_tls1" {
  name        = "group3-ec2-sg-1"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

#   egress = [
#     {
#       from_port        = 0
#       to_port          = 0
#       protocol         = "-1"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
#     }
#   ]

  depends_on = [
    module.vpc
  ]

}

#   ingress = [
#     {
#       description      = "Access for lb"
#       from_port        = 8000
#       to_port          = 8000
#       protocol         = "tcp"
#       cidr_blocks      = ["10.0.0.0/27"]
#     },
#     {
#       description      = "Access for db"
#       from_port        = 3306
#       to_port          = 3306
#       protocol         = "tcp"
#       cidr_blocks      = ["10.0.0.0/24"]
#     },
#     {
#       description      = "SSH"
#       from_port        = 22
#       to_port          = 22
#       protocol         = "tcp"
#       cidr_blocks      = ["10.0.0.10/32"]
#     },
#   ]



#   tags = {
#     Name = "allow_tls"
#   }

#   depends_on = [
#     module.vpc
#   ]

# }