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
  name        = "allow_web_ports"
  description = "Allow web inbound traffic"

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

resource "aws_security_group" "allow_adminer" {
  name        = "allow_adminer"
  description = "Allow adminer"

  ingress {
    from_port   = "${var.adminer_port}"
    to_port     = "${var.adminer_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_admine"
  }
}

resource "aws_security_group" "allow_outbound" {
  name        = "allow_outbound"
  description = "Allow access to internet"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_outbound"
  }
}


resource "aws_instance" "dokku" {
  ami           = "${data.aws_ami.ubuntu16.id}"
  instance_type = "${var.ec2_type}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  key_name = "${aws_key_pair.key_ec2.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}", "${aws_security_group.allow_web_ports.id}", "${aws_security_group.allow_outbound.id}", "${aws_security_group.allow_adminer.id}"]
  tags {
    Name = "Dokku"
  }
  user_data       = "${data.template_file.dokku_provisioning.rendered}"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 30
    delete_on_termination = true
  }
}

resource "aws_eip" "eip_dokku" {
  instance = "${aws_instance.dokku.id}"
  vpc      = true
}