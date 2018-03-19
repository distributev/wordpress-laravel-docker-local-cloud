
resource "aws_db_instance" "db" {
  allocated_storage      = "${var.storage}"
  engine                 = "mysql"
  engine_version         = "${var.mysql_version}"
  instance_class         = "${var.instance_class}"
  name                   = "${var.mysql_db_name}"
  username               = "${var.mysql_user}"
  password               = "${var.mysql_password}"
  availability_zone      = "${data.aws_availability_zones.available.names[0]}"
  vpc_security_group_ids = ["${aws_security_group.db.id}"]
  publicly_accessible    = "${var.publicly_accessible}"
  skip_final_snapshot    = true
}



resource "aws_security_group" "db" {
  name          = "rds_sg"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "rds_sg"
  }
}

