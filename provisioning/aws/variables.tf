variable "aws_region" {
  default = "eu-west-1"
  description = "AWS region"
}

variable "key_ec2" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDihlYyUy+yLV7qspj8uYEGBL8mLSvvgAQoM5OXeMJ0J2vVbBs/+oeRQkG/I4cymqOphjtLFMwmGRNtUWg7jQ/6ASLsh4grCS1Zf/hwBtAC0llvHX6zzg8jWeKglET5Ef7fPHJb6VOLepJdotHkYnG00XMMI5tu5fjGi7+eGNAl4GhTzv7aq/SloFRO4vX4N9fzllUKJNL/Sac+qyJzyzo3sNuc5QlxgPwnIeP06pm679yx2uE5pjik2YTSUZe5w5lzYjVlsHYqXAqfd4mWAdnIYNHo+CZDV5MfsA1RSQeBSg7m84sTOl0bzT15+Elye5Xj0HzSPD0JJhmfuD+AAUAJ test@aws"
  description = "public key authorized in EC2"
}

variable "key_dokku" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDihlYyUy+yLV7qspj8uYEGBL8mLSvvgAQoM5OXeMJ0J2vVbBs/+oeRQkG/I4cymqOphjtLFMwmGRNtUWg7jQ/6ASLsh4grCS1Zf/hwBtAC0llvHX6zzg8jWeKglET5Ef7fPHJb6VOLepJdotHkYnG00XMMI5tu5fjGi7+eGNAl4GhTzv7aq/SloFRO4vX4N9fzllUKJNL/Sac+qyJzyzo3sNuc5QlxgPwnIeP06pm679yx2uE5pjik2YTSUZe5w5lzYjVlsHYqXAqfd4mWAdnIYNHo+CZDV5MfsA1RSQeBSg7m84sTOl0bzT15+Elye5Xj0HzSPD0JJhmfuD+AAUAJ test@aws"
  description = "public key authorized in Dokku"
}

variable "ec2_type" {
  default = "t2.micro"
  description = "Ec2 type"
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
