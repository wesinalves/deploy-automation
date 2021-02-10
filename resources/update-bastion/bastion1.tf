resource "aws_instance" "bastion" {
  # ... existing code ...
  
  user_data = file("./templates/bastion/user-data.sh")

  # ... existing code ...
}