# Configure the Docker repository
resource "null_resource" "docker_repo" {
  provisioner "remote-exec" {
    connection {
      host        = "${var.vm_ip}"
      user        = "${var.vm_user}"
      private_key = file("${path.module}/id_rsa") 
    }
    inline = [
      "sudo add-apt-repository \
       'deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) stable'",
    ]
  }
}

# Update package lists
resource "null_resource" "update_apt" {
  triggers = toset([null_resource.docker_repo.triggers])
  provisioner "remote-exec" {
    connection {
      host        = "${var.vm_ip}"
      user        = "${var.vm_user}"
      private_key = file("${path.module}/id_rsa") 
    }
    inline = [
      "sudo apt-get update",
    ]
  }
}

# Install Docker Engine
resource "null_resource" "install_docker" {
  triggers = toset([null_resource.update_apt.triggers])
  provisioner "remote-exec" {
    connection {
      host        = "${var.vm_ip}"
      user        = "${var.vm_user}"
      private_key = file("${path.module}/id_rsa") 
    }
    inline = [
      "sudo apt-get install -y docker.io",
    ]
  }
}

# Start Docker service
resource "null_resource" "start_docker" {
  triggers = toset([null_resource.install_docker.triggers])
  provisioner "remote-exec" {
    connection {
      host        = "${var.vm_ip}"
      user        = "${var.vm_user}"
      private_key = file("${path.module}/id_rsa") 
    }
    inline = [
      "sudo systemctl start docker",
    ]
  }
}

# Verify Docker installation (optional)
# ... (Similar to local installation, but using remote-exec)












/** provider "docker" {}

resource "docker_image" "nginx-image" {
  name = "nginx"
}

resource "docker_container" "nginx" {
  image = docker_image.nginx-image.latest
  name  = "nginx"
  ports {
    internal = 80
    external = var.external_port
    protocol = "tcp"
  }
}

output "url" {
  description = "Browser URL for container site"
  value       = join(":", ["http://localhost", tostring(var.external_port)])
}**/
