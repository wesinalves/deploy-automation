#############################
# Database setup Assignment #
#############################

# Instructions:
#  Modify the below Terraform to make the following changes:
#  1. Modify the health check to check an endpoint called /api/health-check/
#  2. Modify the health check to expect a HTTP 204 response
#  3. Modify the load balancer to accept connections on port 8080 instead of 80

# Hints:
#  - Official docs relating to health checks:
#     https://www.terraform.io/docs/providers/aws/r/lb_target_group.html#matcher
#  - Official docs relating to listeners (for accepting connections):
#     https://www.terraform.io/docs/providers/aws/r/lb_listener.html#port
#  - Don't forget about the security group :)

resource "aws_lb_target_group" "main" {
  name        = "assignment-main-lb-tg"
  protocol    = "HTTP"
  target_type = "ip"
  port        = 8000
  vpc_id      = aws_vpc.main.id

  health_check {
    path    = "/admin/health-check/"
    matcher = "204"
  }
}


resource "aws_lb" "main" {
  name               = "assignment-main-lb"
  load_balancer_type = "application"

  subnets = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  security_groups = [aws_security_group.lb.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_security_group" "lb" {
  description = "Assignment lb security group"
  name        = "assignment-lb"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "tcp"
    from_port   = 8000
    to_port     = 8000
    cidr_blocks = ["0.0.0.0/0"]
  }
}
