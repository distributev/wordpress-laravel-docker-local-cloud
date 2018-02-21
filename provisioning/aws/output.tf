output "dokku_ip" {
  value = "${aws_eip.eip_dokku.public_ip}"
}