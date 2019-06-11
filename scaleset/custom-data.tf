data "template_file" "custom-data" {
  template = "${file("${path.module}/custom-data.sh")}"

  # vars {
  #   scale_set_name = "${var.cluster_name}-server"
  #   subscription_id = "${var.subscription_id}"
  #   tenant_id = "${var.tenant_id}"
  #   client_id = "${var.client_id}"
  #   secret_access_key = "${var.secret_access_key}"
  # }
}
