variable "key_ec2" {}
variable "key_dokku" {}
variable "domain" {}
variable "app_name" {}
variable "site_title" {}
variable "admin_user" {}
variable "admin_email" {}
variable "dokku_version" {}
variable "adminer_port" {}
variable "ec2_type" {}
variable "ec2_user" {}
variable "rds_mysql_user" {}
variable "rds_mysql_password" {}
variable "mysql_version" {}
variable "mysql_db_name" {}
variable "rds_host" {} #no need to be set anywhere, it's grabbed from rds module automatically
variable "admin_pass" {}
variable "dokku_mysql_password" {}
variable "ec2_password" {}
variable "connect_to_rds" {}
variable "ebs_device_name" {
  default = "/dev/xvdh"
  description = "device name of the mounted volume, no need to change!"
}
