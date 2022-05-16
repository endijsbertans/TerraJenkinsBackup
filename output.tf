output"instance_public_ip"{
    description = "IP of Jenkins"
    value = ["${aws_instance.web.public_ip}:8080"]
}
