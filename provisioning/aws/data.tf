data "aws_ami" "ubuntu16" {
  most_recent = true

  filter {
    name   = "name"
    values = ["*ubuntu-xenial*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["099720109477"] # Ubutnu
}

data "template_file" "dokku_provisioning" {
    template = "${file("${path.module}/provision.sh")}"

    vars {
        dokku_version = "${var.dokku_version}"
        domain = "${var.domain}"
        key_dokku = "${var.key_dokku}"
        app_name = "${var.app_name}"
    }
}