variable "ingress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default     = [
        # {
        #   from_port   = 22
        #   to_port     = 22
        #   protocol    = "tcp"
        #   cidr_block  = "1.2.3.4/32"
        #   description = "test"
        # },
        # {
        #   from_port   = 23
        #   to_port     = 23
        #   protocol    = "tcp"
        #   cidr_block  = "1.2.3.4/32"
        #   description = "test"
        # },
        {
          description      = "Access for lb"
          from_port        = 8000
          to_port          = 8000
          protocol         = "tcp"
          cidr_block       = "10.0.0.0/27"
        },
        {
          description      = "Access for db"
          from_port        = 3306
          to_port          = 3306
          protocol         = "tcp"
          cidr_block       = "10.0.0.0/24"
        },
        {
          description      = "SSH"
          from_port        = 22
          to_port          = 22
          protocol         = "tcp"
          cidr_block       = "10.0.0.10/32"
        },
    ]
}

variable "ingress_rules_1" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default     = [
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "test"
        }
        
    ]
}

variable "egress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default     = [
        {
          from_port        = 0
          to_port          = 0
          protocol         = "-1"
          cidr_block      = "0.0.0.0/0"
          description = "test"
        }
        
    ]
}