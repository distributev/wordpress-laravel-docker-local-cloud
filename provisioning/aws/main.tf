provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_key_pair" "key_ec2" {
  key_name   = "key_ec2"
  public_key = "${var.key_ec2}"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_web_ports" {
  name        = "allow_vpn_ports"
  description = "Allow ssh inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_web_ports"
  }
}


resource "aws_instance" "dokku" {
  ami           = "${data.aws_ami.ubuntu16.id}"
  instance_type = "${var.ec2_type}"
  key_name = "${aws_key_pair.key_ec2.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}", "${aws_security_group.allow_web_ports.id}"]
  tags {
    Name = "Dokku"
  }
  user_data       = "${data.template_file.dokku_provisioning.rendered}"
}

resource "aws_eip" "eip_dokku" {
  instance = "${aws_instance.dokku.id}"
  vpc      = true
}
