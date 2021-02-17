# ... existing code ...

data "template_file" "api_container_definition" {
    # ... existing code ...
    
    vars = {
        # ... existing code ...
        allowed_hosts     = aws_lb.api.dns_name
        # ...existing code ...
    }
}


resource "aws_security_group" "ecs_service" {
    # ... existing code ...
    
    ingress {
        from_port = 8000
        # ... existing code ...
        security_groups = [
            aws_security_group.lb.id
        ]
    }
}


resource "aws_ecs_service" "api" {
    
    # ... existing code ...
    
    network_configuration {
        subnets = [
            aws_subnet.private_a.id,
            aws_subnet.private_b.id,
        ]
        security_groups = [aws_security_group.ecs_service.id]
    }
    
    load_balancer {
        target_group_arn = aws_lb_target_group.api.arn
        container_name   = "proxy"
        container_port   = 8000
    }
}