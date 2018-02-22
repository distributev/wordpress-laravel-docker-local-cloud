variable "aws_access_key" {
  default = ""
  description = "AWS key"
}

variable "aws_secret_key" {
  default = ""
  description = "AWS secret"
}

variable "aws_region" {
  default = "eu-west-1"
  description = "AWS region"
}

variable "key_ec2" {
  default = ""
  description = "public key authorized in EC2"
}

variable "key_dokku" {
  default = ""
  description = "public key authorized in Dokku"
}

variable "ec2_type" {
  default = "t2.micro"
  description = "Ec2 type"
}

variable "ebs_device_name" {
  default = "/dev/xvdh"
  description = "device name of the mounted volume, no need to change!"
}

variable "dokku_version" {
  default = "v0.11.3"
  description = "all services will be accessible through service.domain.tld"
}

variable "domain" {
  default = "domain.tld"
  description = "all services will be accessible through service.domain.tld"
}

variable "app_name" {
  default = "wordpress"
  description = "application name to deploy. the app will be available at http://wordpress.domain.tld"
}

variable "mysql_version" {
  default = "8.0"
  description = "MySQL version that will be deployed"
}

variable "mysql_db_name" {
  default = "wordpress-db"
  description = "mysql database name"
}

variable "site_title" {
  default = "wordpress"
}

variable "admin_user" {
  default = "admin"
  description = "admin user to access wordpress dashboard"
}

variable "admin_pass" {
  default = "password"
  description = "admin password to access wordpress dashboard"
}

variable "admin_email" {
  default = "admin@domain.tld"
}
