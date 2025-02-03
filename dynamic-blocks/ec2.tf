 resource "aws_instance" "this" {
    ami     = "ami-09c813fb71547fc4f"
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
    instance_type = "t3.micro"
    tags = {
        Name = "terraform-demo"
    }
    
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

dynamic "ingress" {

 for_each = [22,8080,3306]
 iterator = "port"
 content {
   from_port       = port.value
    to_port         = port.value
    protocol        = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
 }
 }
  tags = {
    Name = "allow_tls"
  }
}

