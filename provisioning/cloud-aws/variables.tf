################### EC2 module variables ####################
variable "key_ec2" {
  default = ""
  description = "public key authorized in EC2"
}

variable "key_dokku" {
  default = ""
  description = "public key authorized in Dokku"
}

variable "domain" {
  default = "domain.tld"
  description = "all services will be accessible through service.domain.tld, required"
}

variable "app_name" {
  default = "wordpress"
  description = "application name to deploy. the app will be available at http://wordpress.domain.tld"
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
  description = "admin password to access wordpress dashboard. Set it in secret.auto.tfvars"
}

variable "admin_email" {
  default = "admin@domain.tld"
}

variable "dokku_version" {
  default = "v0.11.3"
  description = "all services will be accessible through service.domain.tld"
}

variable "adminer_port" {
  default = "9000"
  description = "adminer will be reachabled through domain.tld:adminer_port"
}

variable "ec2_type" {
  default = "t2.micro"
  description = "Ec2 type"
}

variable "ec2_user" {
  default = ""
  description = "create sudo priviliged user in the system"
}
variable "ec2_password" {
  default = ""
  description = "password for ec2_user. Set it in secret.auto.tfvars"
}
variable "dokku_mysql_password" {
  default = ""
  description = "optionel, will be auto-generated by dokku-mysql when not set. Set it in secret.auto.tfvars"
}
variable "connect_to_rds" {
  default = "yes"
  description = "yes: connect to rds, otherwise: connect to dokku-mysql"
}
################### EC2 module variables ####################


################### RDS module variables ####################
variable "rds_mysql_user" {
  default = "mysql_admin"
  description = "required, rds username"
}

variable "rds_mysql_password" {
  default = ""
  description = "required, rds password. Set it in secret.auto.tfvars"
}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "storage" {
  default = "10"
}

variable "publicly_accessible" {
  default = "0"
  description = "1: rds is reachable publicly, 0: reachable only from the vpc, more secure"
}

################### RDS module variables ####################


################### Shared variables between RDS and EC2 module ####################
variable "mysql_db_name" {
  default = "wordpress"
  description = "mysql database name"
}

variable "mysql_version" {
  default = "5.7"
  description = "MySQL version that will be deployed in dokku-mysql and rds"
}
################### Shared variables between RDS and EC2 module ####################


################### General variables ####################
variable "aws_access_key" {
  default = ""
  description = "AWS key. Set it in secret.auto.tfvars"
}
variable "aws_secret_key" {
  default = ""
  description = "AWS secret. Set it in secret.auto.tfvars"
}

variable "aws_region" {
  default = "eu-west-1"
  description = "AWS region"
}
################### General variables ####################

