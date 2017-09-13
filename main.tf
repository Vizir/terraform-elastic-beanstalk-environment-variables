resource "null_resource" "environment_variables" {
  triggers {
    environment_variables = "${var.environment_variables}"
  }

  provisioner "local-exec" {
    command = <<EOF
      ${path.module}/update-beanstalk-env \
        -a ${var.application} \
        -p ${var.aws_profile} \
        -e ${var.environment} \
        -f- \
        -r ${var.aws_region} <<ENV
${var.environment_variables}
ENV
EOF
  }
}
