resource "aws_default_vpc" "default" {}
resource "aws_instance" "bastion" {
  ami                         = "ami-0fb653ca2d3203ac1"
  instance_type               = "t2.micro"
  key_name =                  "ansible_key"
  security_groups             = ["${aws_security_group.bastion-sg.name}"]
  associate_public_ip_address = true
}

resource "aws_security_group" "bastion-sg" {
  name   = "bastion-security-group"
  vpc_id = "${aws_default_vpc.default.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0 
    to_port     = 0 
    cidr_blocks = ["0.0.0.0/0"]
  }
}
