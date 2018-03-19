provider "aws" {
  access_key              = "${var.aws_access_key}"
  secret_key              = "${var.aws_secret_key}"
  region                  = "${var.aws_region}"
}


module "ec2" {
  source                  = "./ec2"
  rds_mysql_user          = "${var.rds_mysql_user}"
  rds_mysql_password      = "${var.rds_mysql_password}"
  mysql_version           = "${var.mysql_version}"
  mysql_db_name           = "${var.mysql_db_name}"
  rds_host                = "${module.rds.db_instance_address}"
  admin_pass              = "${var.admin_pass}"
  dokku_mysql_password    = "${var.dokku_mysql_password}"
  ec2_password            = "${var.ec2_password}"
  ec2_user                = "${var.ec2_user}"
  key_dokku               = "${var.key_dokku}"
  admin_user              = "${var.admin_user}"
  admin_email             = "${var.admin_email}"
  site_title              = "${var.site_title}"
  dokku_version           = "${var.dokku_version}"
  ec2_type                = "${var.ec2_type}"
  key_ec2                 = "${var.key_ec2}"
  domain                  = "${var.domain}"
  app_name                = "${var.app_name}"
  adminer_port            = "${var.adminer_port}"
}



module "rds" {
  source                  = "./rds"
  instance_class          = "${var.instance_class}"
  storage                 = "${var.storage}"
  publicly_accessible     = "${var.publicly_accessible}"
  mysql_user              = "${var.rds_mysql_user}"
  mysql_password          = "${var.rds_mysql_password}"
  mysql_version           = "${var.mysql_version}"
  mysql_db_name           = "${var.mysql_db_name}"
}
