terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.70"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = var.yandex_token
  cloud_id  = var.yandex_cloud_id
  folder_id = var.yandex_folder_id
}

data "yandex_vpc_network" "my_vpc" {
  network_id = var.vpc_id
}

data "yandex_vpc_subnet" "all_subnets" {
  for_each = toset(data.yandex_vpc_network.my_vpc.subnet_ids)
  subnet_id = each.value
}

locals {
  subnets_in_zone = [for s in data.yandex_vpc_subnet.all_subnets : s.id if s.zone == var.zone]
}

resource "yandex_compute_instance" "vm_instance" {
  name        = "vm-instance"
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd808e721rc1vt7jkd0o" # Ubuntu 20.04 LTS
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key_path)}"
  }

  provisioner "file" {
    source      = var.ssh_private_key_path
    destination = "/home/ubuntu/id_rsa"
    connection {
      type        = "ssh"
      host        = self.network_interface[0].nat_ip_address
      user        = "ubuntu"
      private_key = file(var.ssh_private_key_path)
    }
  }

  provisioner "file" {
    source      = var.ssh_public_key_path
    destination = "/home/ubuntu/id_rsa.pub"
    connection {
      type        = "ssh"
      host        = self.network_interface[0].nat_ip_address
      user        = "ubuntu"
      private_key = file(var.ssh_private_key_path)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/ubuntu/id_rsa",
      "ssh-keyscan -H ${self.network_interface[0].nat_ip_address} >> ~/.ssh/known_hosts",
    ]
    connection {
      type        = "ssh"
      host        = self.network_interface[0].nat_ip_address
      user        = "ubuntu"
      private_key = file(var.ssh_private_key_path)
    }
  }
}

output "vm_instance_ip" {
  value = yandex_compute_instance.vm_instance.network_interface[0].nat_ip_address
}