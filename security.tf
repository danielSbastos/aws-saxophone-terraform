resource "aws_security_group" "security-group" {
  name        = "allow_port_400"
  description = "Allow inbound traffic from port 4000"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
