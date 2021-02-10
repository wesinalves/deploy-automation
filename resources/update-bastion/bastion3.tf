resource "aws_instance" "bastion" {
    # ... existing code ...
    
    subnet_id = aws_subnet.public_a.id
    key_name  = var.bastion_key_name
    
    # ... existing code ...
}