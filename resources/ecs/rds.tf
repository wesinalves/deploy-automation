resource "aws_security_group" "rds" {
  # ... existing code ...

  ingress {
  # ... existing code ...
    security_groups = [
      aws_security_group.ecs_service.id,
    ]
  }

  # ... existing code ..
}
