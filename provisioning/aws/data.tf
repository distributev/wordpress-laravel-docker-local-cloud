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
        ebs_device_name = "${var.ebs_device_name}"
        dokku_version = "${var.dokku_version}"
        domain = "${var.domain}"
        key_dokku = "${var.key_dokku}"
        app_name = "${var.app_name}"
        mysql_version = "${var.mysql_version}"
        mysql_db_name = "${var.mysql_db_name}"
        site_title = "${var.site_title}"
        admin_user = "${var.admin_user}"
        admin_pass = "${var.admin_pass}"
        admin_email = "${var.admin_email}"
        adminer_port = "${var.adminer_port}"
    }
}

data "aws_availability_zones" "available" {}